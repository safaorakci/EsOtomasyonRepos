; (function ($, db) {
    var Note; // Initialize note

    /**
     * Format timestamp in a specified format
     * @param  {int} time Time in integer format
     * @return {string}      Formated time string
     */
    function _formatDate(time) {
        return moment(Number(time)).format('DD MMMM YYYY dddd, hh:mm');
    }

    /**
     * Escape HTML tags
     * @param  {string} html Unescaped content
     * @return {string}      HTML escaped content
     */
    function _escapeHtml(html) {
        return $('<div />').text(html).html();
    }

    // Debouncer to imporve performance
    function _debounce(func, wait, immediate) {
        var timeout;
        return function () {
            var context = this, args = arguments;
            var later = function () {
                timeout = null;
                if (!immediate) func.apply(context, args);
            };
            var callNow = immediate && !timeout;
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
            if (callNow) func.apply(context, args);
        };
    };

    Note = {
        // DOM selectors
        $list: $('#Note-list'), // Note list wrapper
        $pad: $('#Note-pad'), // Note writing box
        $created: $('#Note-created__date'), // Note created date holder
        $add: $('.Note-add'), // Note create button
        $search: $('#Note-search'), // Note search box

        _length: 0, // Length of notes
        _lastIndex: 0, // Last note index

        _PREFIX: 'TB', // DB record key prefix
        _UID_SEPERATOR: '-', // Seperator between prefix and index

        init: function () {
            // Event must be called before render
            Note.addEvents();
            Note.render();
        },

        /**
         * Render full note list
         * @return {object} Note module object
         */
        render: function () {
            var templates = [];
            Note._length = 0;

            /**
             * Loop through all DB entry and prepare only valid note for output
             * @param  {string} key    DB entry key
             * @param  {object} entry  DB entry object
             * @return {void}
             */
            db.forEach(function (key, entry) {
                if (Note._isValid(key)) {
                    templates.unshift(Note._getNoteTemplate(entry));
                    ++Note._length;

                    if (entry.id > Note._lastIndex) {
                        Note._lastIndex = entry.id;
                    }
                }
            });

            Note._renderList(templates);
            return this;
        },

        /**
         * Bind event listeners to DOM elements
         */
        addEvents: function () {
            // Note open handler
            Note.$list.on('click', '.Note', function () {
                var note = $(this),
                    noteWrapper = note.parent(),
                    id = note.data('uid');

                if (id) Note.open(id);
                noteWrapper.addClass('active').siblings().removeClass('active');
            });

            // Note delete handler
            Note.$list.on('click', '.Note-delete', function (e) {
                e.preventDefault();
                Note.delete($(this).data('uid'));
                $(this).parent().remove();
                Note.$pad.val(' ');
                if (!Note._length) {
                    Note.$created.text('');
                }

                var toplanti_id = $("#toplanti_id").val();

                var data = "islem=toplanti_not_guncelle";
                data += "&toplanti_id=" + toplanti_id;
                data += "&notlar=";
                db.forEach(function (key, entry) {
                    if (entry.title != undefined) {
                        data += encodeURIComponent(entry.title) + "~" + encodeURIComponent(entry.content) + "|";
                    }
                });
                $("#koftiden").loadHTML({ url: "/ajax_request/", data: data }, function () { });


            });

            // Note create handler
            Note.$add.on('click', function (e) {
                e.preventDefault();
                Note.create({}).render();
            });

            // Create a note on focus if there is no note
            Note.$pad.on('focus', function () {
                if (!Note._length) {
                    Note.create({}).render();
                }
            });

            // Update note on keyup
            Note.$pad.on('keyup', _debounce(function (e) {
                var title,
                    content = Note.$pad.val(),
                    $note = $('.Note[data-uid="' + Note.$pad.data('uid') + '"');

                if (-1 !== content.indexOf('\n')) {
                    title = content.slice(0, content.indexOf('\n'));
                    Note.update(Note.$pad.data('uid'), { title: title, content: content });
                    $note.find('.Note__name').text(title);
                    $note.find('.Note__desc').text(Note._getPartialContent(content, title));
                }
            }, 200));

            // Search note
            Note.$search.on('keyup', _debounce(function () {
                Note.search(Note.$search.val());
            }, 200));
        },

        /**
         * Create note
         * @param  {object} data Note data object
         * @return {object}      Note module object
         */
        create: function (data) {
            if ('object' !== $.type(data)) {
                return new Error('Hata Oluştu.');
            }

            var defaults = {
                id: ++Note._lastIndex,
                title: 'Not Başlığı',
                content: '',
                time: new Date().getTime()
            };

            $.extend(defaults, data);
            store.set(Note._getUID(defaults.id), defaults);
            return this;
        },

        /**
         * Update note
         * @param  {string} key  Note record key
         * @param  {object} note Note data object
         * @return {object}      Note module object
         */
        update: function (key, note) {
            if (!Note._isValid(key)) {
                return new Error('Hata Oluştu');
            }
            db.transact(key, function (old) {
                old = $.extend(old, note);
            });

            var toplanti_id = $("#toplanti_id").val();
            
            var data = "islem=toplanti_not_guncelle";
            data += "&toplanti_id=" + toplanti_id;
            data += "&notlar=";
            db.forEach(function (key, entry) {
                if (entry.title!=undefined) {
                    data += encodeURIComponent(entry.title) + "~" + encodeURIComponent(entry.content) + "|";
                }
            });
            $("#koftiden").loadHTML({ url: "/ajax_request/", data: data }, function () {});

            return this;
        },

        /**
         * Delete note
         * @param  {string} key Note record key
         * @return {object}     Note module object
         */
        delete: function (key) {
            if (!Note._isValid(key)) {
                return new Error('Hata Oluştu');
            }
            store.remove(key);
            --Note._length;
           
            return this;
        },

        /**
         * Open note to writing box and setup UI
         * @param  {string} key Note record key
         * @return {object}     Note module object
         */
        open: function (key) {
            if (!Note._isValid(key)) {
                return new Error('Invalid note key.');
            }
            var note = db.get(key);
            Note.$pad.val(note.content).data('uid', Note._getUID(note.id));
            Note.$created.text(_formatDate(note.time));
            return this;
        },

        /**
         * Search note in DB and render search result
         * @param  {string} term Search term given by user
         * @return {void}
         */
        search: function (term) {
            var templates = [], termRegx = new RegExp(term, 'gi');

            db.forEach(function (key, entry) {
                if (Note._isValid(key) && (termRegx.test(entry.content) || termRegx.test(entry.title))) {
                    templates.unshift(Note._getNoteTemplate(entry));
                }
            });
            Note._renderList(templates);
        },

        /**
         * Render note list and select first note
         * @param  {array} templates Array of complied note templates
         * @return {void}
         */
        _renderList: function (templates) {
            Note.$list.html(templates).children(':first-child').find('.Note').trigger('click');
            templates.length || Note.$pad.val(''); // Clear note pad when there is no note
        },

        /**
         * Get note list item HTML template
         * @param  {object} data Single note object
         * @return {string}      Output ready note list item
         */
        _getNoteTemplate: function (data) {
            var template = '<li class="list-group-item">'
                + '<button class="Note-delete" data-uid="' + Note._getUID(data.id) + '" type="button">x</button>'
                + '<div class="Note" data-uid="' + Note._getUID(data.id) + '">'
                + '<div class="Note__name">' + _escapeHtml(data.title) + '</div>'
                + '<div class="Note__desc">' + _escapeHtml(Note._getPartialContent(data.content, data.title)) + '</div>'
                + '<span class="Note__date">' + _formatDate(data.time) + '</span>'
                + '</div>'
                + '</li>';

            return template;
        },

        _getPartialContent: function (content, title) {
            return content.slice(title.length);
        },

        // Generate UID
        _getUID: function (id) {
            return Note._PREFIX + Note._UID_SEPERATOR + id;
        },

        /**
         * Check note entry validity
         * @param  {string}  key Entry key
         * @return {Boolean}     Check if it is valid note entry
         */
        _isValid: function (key) {
            return key && (String(key).indexOf(Note._PREFIX) === 0);
        }
    };

    //db.set(demoNotes, true);
    var demoNotes = [];

    $(".notlar").each(function () {
        demoNotes.push({
            title: $(this).attr("baslik"),
            content: $(this).attr("icerik"),
            time : new Date($(this).attr("yil"), $(this).attr("ay"), $(this).attr("gun"), $(this).attr("saat"), $(this).attr("dakika"), 0, 0).getTime()
        });
    });


    for (var i = 0; i < 50; i++) {
        Note.delete("TB-" + i);
    }
    
    demoNotes.forEach(function (demoNote) {
        Note.create(demoNote);
    });

    Note.init();

    /**
     * Only for demo purpose, feel free to delete
     */

    /*
    if (!db.get('demo_imported')) {
        var demoNotes = [{
            title: 'Lorem İpsum Nedir?',
            content: 'Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960 larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.'
        },
                  {
                      title: 'Lorem İpsum Nedir?',
                      content: 'Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960 larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.'
                  },
                  {
                      title: 'Lorem İpsum Nedir?',
                      content: 'Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960 larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.'
                  }];

        demoNotes.forEach(function (demoNote) {
           Note.create(demoNote);
        });

        Note.render();
        db.set('demo_imported', true);
    }*/

    window.TB_Note = Note;
})(jQuery, store);