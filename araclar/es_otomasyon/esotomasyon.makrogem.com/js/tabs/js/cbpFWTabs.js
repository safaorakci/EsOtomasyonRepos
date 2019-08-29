/**
 * cbpFWTabs.js v1.0.0
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2014, Codrops
 * http://www.codrops.com
 */
; (function (window) {

    'use strict';

    function extend(a, b) {
        for (var key in b) {
            if (b.hasOwnProperty(key)) {
                a[key] = b[key];
            }
        }
        return a;
    }

    function CBPFWTabs(el, options) {
        this.el = el;
        this.options = extend({}, this.options);
        extend(this.options, options);
        this._init();
    }

    CBPFWTabs.prototype.options = {
        start: 0
    };

    CBPFWTabs.prototype._init = function () {
        // tabs elems
        this.tabs = [].slice.call(this.el.querySelectorAll('nav > ul > li'));
        // content items
        this.items = [].slice.call(this.el.querySelectorAll('.content-wrap > section'));
        // current index
        this.current = -1;
        // show current content item
        this._show();
        // init events
        this._initEvents();
    };

    CBPFWTabs.prototype._initEvents = function () {
        var self = this;
        this.tabs.forEach(function (tab, idx) {
            tab.addEventListener('click', function (ev) {
                ev.preventDefault();
                self._show(idx);
            });
        });
    };

    CBPFWTabs.prototype._show = function (idx) {

        if ($("#cikma_kontrol").val() == "true") {
            var r = confirm("Yaptığınız Değişiklikler Kaydedilmemiş Olabilir. Çıkmak İstediğinize Emin misiniz? ");
            if (!r) {
                return false;
            }
        }

        console.log(this.current);

        if (this.current >= 0) {
            if (this.items[this.current].className !== undefined) {
                this.tabs[this.current].className = this.items[this.current].className = '';
            }

        }
        // change current
        this.current = idx !== undefined ? idx : this.options.start >= 0 && this.options.start < this.items.length ? this.options.start : 0;
        this.tabs[this.current].className = 'tab-current';
        this.items[this.current].className = 'content-current';


        setTimeout(function () {
            if (eldeki_function == 1) {
                proje_olaylar_getir(eldeki_proje_id, eldeki_departman_id, eldeki_nesne);
            } else if (eldeki_function == 2) {
                proje_planlama_getir(eldeki_proje_id, eldeki_tip, eldeki_nesne);
            } else if (eldeki_function == 3) {
                proje_satinalma_getir(eldeki_proje_id, eldeki_nesne);
            } else if (eldeki_function == 4) {
                proje_gelir_getir(eldeki_proje_id, eldeki_nesne);
            } else if (eldeki_function == 5) {
                proje_ajanda_getir(eldeki_proje_id, eldeki_nesne);
            } else if (eldeki_function == 6) {
                proje_dosyalari_getir(eldeki_proje_id, eldeki_nesne);
            } else if (eldeki_function == 7) {
                proje_is_listesi_getir(eldeki_proje_id, eldeki_nesne);
            } else if (eldeki_function == 8) {
                santiye_adam_saat_getir(eldeki_proje_id, eldeki_nesne);
            } else if (eldeki_function == 9) {
                santiye_rapor_getir(eldeki_proje_id, eldeki_nesne);
            } else if (eldeki_function == 10) {
                console.log(eldeki_proje_id);
                servis_getir(eldeki_proje_id, eldeki_nesne);
            }
            eldeki_function = 0;
        }, 250);





    };

    // add to global namespace
    window.CBPFWTabs = CBPFWTabs;

})(window);