<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    proje_id = trn(request("id"))
    departman_id = trn(request("departman_id"))

    projeid = trn(request("proje_id"))
    tip = trn(request("tip"))

    SQL="select firma.firma_adi, * from ucgem_proje_listesi proje join ucgem_firma_listesi firma on firma.id = proje.proje_firma_id where proje.id = '"& proje_id &"'"
    set firma = baglanti.execute(SQL)
   
%>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="/js/gantt/ganttUtilities.js"></script>
<script src="/js/gantt/ganttTask.js"></script>
<script src="/js/gantt/ganttDrawerSVG.js"></script>
<script src="/js/gantt/ganttZoom.js"></script>
<script src="/js/gantt/ganttGridEditor.js"></script>
<script src="/js/gantt/ganttMaster.js"></script>

<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <div class="card-block user-info" style=" bottom: -73px; width:70%;">
                        <div class="media-left">
                            <a href="#" class="profile-image">
                                <img class="user-img img-radius" src="/upload/upload/ahtapot_26.07.2018_10.42.50_GDIbg.jpg" style="width: 140px!important; height:149px!important;">
                            </a>
                        </div>
                    </div>
                </div>
                <div class="d-inline-block" style="padding-left: 175px;">
                    <h5 style="font-size:15px;"><%=firma("proje_adi") %></h5>
                    <span><%=firma("firma_adi") %></span>
                </div>

                 <span style="float:right;">
                    <a href="javascript:void(0);" onclick="santiye_sil('<%=proje_id %>');" class="btn btn-mini btn-danger btn-round" style="color: white; float:right;"><i class="fa fa-search"></i>&nbsp;<%=LNG("Proje Sil")%></a>
                    <a href="javascript:void(0);" onclick="sayfagetir('/santiyeler/','jsid=4559&acilacak=<%=departman_id %>');" class="btn btn-mini btn-labeled btn-success  btn-round" style="color: white; float:right; margin-right:10px;"><span class="btn-label" style="color: white;"><i class="fa fa-history"></i></span>&nbsp;<%=LNG("Geri Dön")%></a>
                </span>


            </div>
        </div>
    </div>
</div>

<style>
    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active i {
        color: #fff !important;
    }

    .yuvarla i {
        font-family: 'themify';
        speak: none;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    .tab-content > .active {
        display: block;
        background-color: white !important;
    }

    .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
        background: #58a5ff;
    }
</style>

<script type="text/javascript">

    var ge;
    var ret;

    $(function () {
        //localStorage.clear();
        var canWrite = true; //this is the default for test purposes

        // here starts gantt initialization
        ge = new GanttMaster();
        ge.set100OnClose = false;
        ge.shrinkParent = false;
        ge.init($("#workSpace"));
        loadI18n(); //overwrite with localized ones

        //in order to force compute the best-fitting zoom level
        delete ge.gantt.zoom;

        /*

        var project = loadFromLocalStorage();

        if (!project.canWrite)
            $(".ganttButtonBar button.requireWrite").attr("disabled", "true");

        ge.loadProject(project);
        ge.checkpoint(); //empty the undo stack

        */

        var asd = loadGanttFromServer('<%=projeid %>');


    });



    function getDemoProject() {
        //console.debug("getDemoProject")
        ret = {
            "tasks": [
                { "id": -1, "name": "sHavalandırma Tesisatı", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 0, "status": "STATUS_ACTIVE", "depends": "", "canWrite": true, "start": 1396994400000, "duration": 20, "end": 1399586399999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": true },


                { "id": -2, "name": "Kanal İmalatı", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 1, "status": "STATUS_ACTIVE", "depends": "", "canWrite": true, "start": 1396994400000, "duration": 10, "end": 1398203999999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": true },

                { "id": -3, "name": "Kanal Uygulama", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_ACTIVE", "depends": "", "canWrite": true, "start": 1396994400000, "duration": 2, "end": 1397167199999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false },

                { "id": -4, "name": "Kanal Vidalama", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_SUSPENDED", "depends": "3", "canWrite": true, "start": 1397167200000, "duration": 4, "end": 1397685599999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false },

                { "id": -5, "name": "Kanal Döşeme", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 1, "status": "STATUS_SUSPENDED", "depends": "2:5", "canWrite": true, "start": 1398981600000, "duration": 5, "end": 1399586399999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": true },

                { "id": -6, "name": "Kalın Döşeme", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_SUSPENDED", "depends": "", "canWrite": true, "start": 1398981600000, "duration": 2, "end": 1399327199999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false },

                { "id": -7, "name": "Orta Boy Döşeme", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_SUSPENDED", "depends": "6", "canWrite": true, "start": 1399327200000, "duration": 3, "end": 1399586399999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false },

                { "id": -8, "name": "İnce Döşeme", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_SUSPENDED", "depends": "6", "canWrite": true, "start": 1399327200000, "duration": 2, "end": 1539980581804, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false }
            ], "selectedRow": 2, "deletedTaskIds": [],
            "resources": [
                { "id": "tmp_1", "name": "Kaynak 1" },
                { "id": "tmp_2", "name": "Kaynak 2" },
                { "id": "tmp_3", "name": "Kaynak 3" },
                { "id": "tmp_4", "name": "Kaynak 4" }
            ],
            "roles": [
                { "id": "tmp_1", "name": "Proje Yöneticisi" },
                { "id": "tmp_2", "name": "İşçi" },
                { "id": "tmp_3", "name": "Taşeron" },
                { "id": "tmp_4", "name": "Müşteri" }
            ], "canWrite": true, "canDelete": true, "canWriteOnParent": true, canAdd: true
        }


        //actualize data
        var offset = new Date().getTime() - ret.tasks[0].start;
        for (var i = 0; i < ret.tasks.length; i++) {
            ret.tasks[i].start = ret.tasks[i].start + offset;
        }
        return ret;
    }


    function iterationCopy(src) {
        let target = {};
        for (let prop in src) {
            if (src.hasOwnProperty(prop)) {
                target[prop] = src[prop];
            }
        }
        return target;
    }

    function loadGanttFromServer(taskId, callback) {

        var asd;
        //this is a simulation: load data from the local storage if you have already played with the demo or a textarea with starting demo data
        //var ret = loadFromLocalStorage();

        //this is the real implementation

        //var taskId = $("#taskSelector").val();
        //var prof = new Profiler("loadServerSide");
        //prof.reset();

        $.getJSON("/ajax_planlama/?jsid=4559&tip=<%=request("tip")%>&proje_id=<%=request("projeid")%>", { CM: "LOADPROJECT", taskId: taskId }, function (response) {
            //console.debug(response);



            if (response.ok) {


                if (!response.project.canWrite)
                    $(".ganttButtonBar button.requireWrite").attr("disabled", "true");


                //prof.stop();

                ge.loadProject(response.project);
                ge.checkpoint(); //empty the undo stack

                if (typeof (callback) == "function") {
                    callback(response);
                }
            } else {
                //jsonErrorHandling(response);
            }
        });


        return asd;
    }


    function saveGanttOnServer() {

        var prj = ge.saveProject();

        //console.log(JSON.stringify(prj));

        //this is a simulation: save data to the local storage or to the textarea
        // saveInLocalStorage();

        delete prj.resources;
        delete prj.roles;

        /*
        var prof = new Profiler("saveServerSide");
        prof.reset();
        */

        /*
        if (ge.deletedTaskIds.length > 0) {
            if (!confirm("TASK_THAT_WILL_BE_REMOVED" + ge.deletedTaskIds.length)) {
                return;
            }
        }*/

        console.log(prj.tasks[0].start);

        $.ajax("/ajax_planlama/", {
            dataType: "json",
            data: { islem: "kayit", tip: "<%=tip%>", proje_id: "<%=request("projeid")%>", prj: JSON.stringify(prj) },
            type: "POST",
            success: function (response) {
                //console.log("girdi");
                window.parent.mesaj_ver("Proje Planı", "<%=LNG("Kayıt Başarıyla Güncellendi")%>", "success");
                if (response.ok) {
                    if (response.project) {
                        ge.loadProject(response.project); //must reload as "tmp_" ids are now the good ones

                    } else {
                        ge.reset();
                    }
                } else {
                    var errMsg = "Hata Oluştu\n";
                    if (response.message) {
                        errMsg = errMsg + response.message + "\n";
                    }

                    if (response.errorMessages.length) {
                        errMsg += response.errorMessages.join("\n");
                    }
                    alert(errMsg);
                }
            }

        });

    }

    function newProject() {
        clearGantt();
    }


    function clearGantt() {
        ge.reset();
    }

    //-------------------------------------------  Get project file as JSON (used for migrate project from gantt to Teamwork) ------------------------------------------------------
    function getFile() {
        $("#gimBaPrj").val(JSON.stringify(ge.saveProject()));
        $("#gimmeBack").submit();
        $("#gimBaPrj").val("");

        /*  var uriContent = "data:text/html;charset=utf-8," + encodeURIComponent(JSON.stringify(prj));
         neww=window.open(uriContent,"dl");*/
    }


    function loadFromLocalStorage() {
        var ret;
        if (localStorage) {
            if (localStorage.getObject("teamworkGantDemo")) {
                ret = localStorage.getObject("teamworkGantDemo");
            }
        }

        //if not found create a new example task
        if (!ret || !ret.tasks || ret.tasks.length == 0) {
            ret = getDemoProject();
        }
        return ret;
    }


    function saveInLocalStorage() {
        var prj = ge.saveProject();
        if (localStorage) {
            localStorage.setObject("teamworkGantDemo", prj);
        }
    }


    //-------------------------------------------  Open a black popup for managing resources. This is only an axample of implementation (usually resources come from server) ------------------------------------------------------
    function editResources() {

        //make resource editor
        var resourceEditor = $.JST.createFromTemplate({}, "RESOURCE_EDITOR");
        var resTbl = resourceEditor.find("#resourcesTable");

        for (var i = 0; i < ge.resources.length; i++) {
            var res = ge.resources[i];
            resTbl.append($.JST.createFromTemplate(res, "RESOURCE_ROW"))
        }


        //bind add resource
        resourceEditor.find("#addResource").click(function () {
            resTbl.append($.JST.createFromTemplate({ id: "new", name: "resource" }, "RESOURCE_ROW"))
        });

        //bind save event
        resourceEditor.find("#resSaveButton").click(function () {
            var newRes = [];
            //find for deleted res
            for (var i = 0; i < ge.resources.length; i++) {
                var res = ge.resources[i];
                var row = resourceEditor.find("[resId=" + res.id + "]");
                if (row.length > 0) {
                    //if still there save it
                    var name = row.find("input[name]").val();
                    if (name && name != "")
                        res.name = name;
                    newRes.push(res);
                } else {
                    //remove assignments
                    for (var j = 0; j < ge.tasks.length; j++) {
                        var task = ge.tasks[j];
                        var newAss = [];
                        for (var k = 0; k < task.assigs.length; k++) {
                            var ass = task.assigs[k];
                            if (ass.resourceId != res.id)
                                newAss.push(ass);
                        }
                        task.assigs = newAss;
                    }
                }
            }

            //loop on new rows
            var cnt = 0
            resourceEditor.find("[resId=new]").each(function () {
                cnt++;
                var row = $(this);
                var name = row.find("input[name]").val();
                if (name && name != "")
                    newRes.push(new Resource("tmp_" + new Date().getTime() + "_" + cnt, name));
            });

            ge.resources = newRes;

            closeBlackPopup();
            ge.redraw();
        });


        var ndo = createModalPopup(400, 500).append(resourceEditor);
    }

    function toplam_calisma_girdim(nesne) {

        var gun_sayisi = $("#duration").val();
        var gunluk_saat = parseFloat($(nesne).val()) / parseFloat(gun_sayisi);
        var taskId = $(nesne).attr("taskId");
        var assId = $(nesne).attr("assId");
        if (gunluk_saat == NaN) {
            gunluk_saat = 0;
        }
        gunluk_saat = parseFloat(Math.round(gunluk_saat * 100) / 100).toFixed(2);
        $("input[name=gunluk_calisma][taskId=" + taskId + "][assId=" + assId + "]").val(gunluk_saat);
    }



    function gunluk_calisma_girdim(nesne) {
        var gun_sayisi = $("#duration").val();
        var toplam_saat = parseFloat($(nesne).val().replace(",", ".")) * parseFloat(gun_sayisi);
        var taskId = $(nesne).attr("taskId");
        var assId = $(nesne).attr("assId");
        if (toplam_saat == NaN) {
            toplam_saat = 0;
        }
        toplam_saat = parseFloat(Math.round(toplam_saat * 100) / 100).toFixed(2);
        $("input[name=effort][taskId=" + taskId + "][assId=" + assId + "]").val(toplam_saat);
    }

    function is_yuku_cizelgesi_ac2(start, end) {
        var start = $("#start").val();
        var end = $("#end").val();
        parent.is_yuku_cizelgesi_ac(start, end);
    }

    function initializeHistoryManagement() {

        //si chiede al server se c'è della hisory per la root
        $.getJSON(contextPath + "/applications/teamwork/task/taskAjaxController.jsp", { CM: "GETGANTTHISTPOINTS", OBJID: 10236 }, function (response) {

            //se c'è
            if (response.ok == true && response.historyPoints && response.historyPoints.length > 0) {

                //si crea il bottone sulla bottoniera
                var histBtn = $("<button>").addClass("button textual icon lreq30 lreqLabel").attr("title", "SHOW_HISTORY").append("<span class=\"teamworkIcon\">&#x60;</span>");

                //al click
                histBtn.click(function () {
                    var el = $(this);
                    var ganttButtons = $(".ganttButtonBar .buttons");

                    //è gi�  in modalit�  history?
                    if (!ge.element.is(".historyOn")) {
                        ge.element.addClass("historyOn");
                        ganttButtons.find(".requireCanWrite").hide();

                        //si carica la history server side
                        if (false) return;
                        showSavingMessage();
                        $.getJSON(contextPath + "/applications/teamwork/task/taskAjaxController.jsp", { CM: "GETGANTTHISTPOINTS", OBJID: ge.tasks[0].id }, function (response) {
                            jsonResponseHandling(response);
                            hideSavingMessage();
                            if (response.ok == true) {
                                var dh = response.historyPoints;
                                //ge.historyPoints=response.historyPoints;
                                if (dh && dh.length > 0) {
                                    //si crea il div per lo slider
                                    var sliderDiv = $("<div>").prop("id", "slider").addClass("lreq30 lreqHide").css({ "display": "inline-block", "width": "500px" });
                                    ganttButtons.append(sliderDiv);

                                    var minVal = 0;
                                    var maxVal = dh.length - 1;

                                    $("#slider").show().mbSlider({
                                        rangeColor: '#2f97c6',
                                        minVal: minVal,
                                        maxVal: maxVal,
                                        startAt: maxVal,
                                        showVal: false,
                                        grid: 1,
                                        formatValue: function (val) {
                                            return new Date(dh[val]).format();
                                        },
                                        onSlideLoad: function (obj) {
                                            this.onStop(obj);

                                        },
                                        onStart: function (obj) { },
                                        onStop: function (obj) {
                                            var val = $(obj).mbgetVal();
                                            showSavingMessage();
                                            $.getJSON(contextPath + "/applications/teamwork/task/taskAjaxController.jsp", { CM: "GETGANTTHISTORYAT", OBJID: ge.tasks[0].id, millis: dh[val] }, function (response) {
                                                jsonResponseHandling(response);
                                                hideSavingMessage();
                                                if (response.ok) {
                                                    ge.baselines = response.baselines;
                                                    ge.showBaselines = true;
                                                    ge.baselineMillis = dh[val];
                                                    ge.redraw();
                                                }
                                            })

                                        },
                                        onSlide: function (obj) {
                                            clearTimeout(obj.renderHistory);
                                            var self = this;
                                            obj.renderHistory = setTimeout(function () {
                                                self.onStop(obj);
                                            }, 200)

                                        }
                                    });
                                }
                            }
                        });


                        // quando si spenge
                    } else {
                        //si cancella lo slider
                        $("#slider").remove();
                        ge.element.removeClass("historyOn");
                        if (ge.permissions.canWrite)
                            ganttButtons.find(".requireCanWrite").show();

                        ge.showBaselines = false;
                        ge.baselineMillis = undefined;
                        ge.redraw();
                    }

                });
                $("#saveGanttButton").before(histBtn);
            }
        })
    }

    function showBaselineInfo(event, element) {
        //alert(element.attr("data-label"));
        $(element).showBalloon(event, $(element).attr("data-label"));
        ge.splitter.secondBox.one("scroll", function () {
            $(element).hideBalloon();
        })
    }


    function karsilastirmali_gosterim_calistir(nesne) {

        if ($(nesne).attr("checked") == "checked") {
            $(nesne).removeAttr("checked")
        } else {
            $(nesne).attr("checked", "checked");
        }

        setTimeout(function () {
            $('#workSpace').trigger('expandAll.gantt');
            if ($("#karsilastirmali_gosterim").attr("checked") != "checked") {
                $(".taskBoxGolge").hide();
            }
        }, 500);

    }

</script>

<div class="row">
    <div class="col-lg-12">
        <div class="tabs tabs-style-bar">
            <nav>
                <ul>
                    <li class="nav-link_yeni"><a tabindex="-1" style="-webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-bottomleft: 10px; border-top-left-radius: 10px; border-bottom-left-radius: 10px;" href="#olaylar_tab" onclick="onbellekten_proje_olaylar_getir('<%=proje_id %>','<%=departman_id %>', this); saveGanttOnServer();" class="tabbuton icon icon-home"><span><%=LNG("Detay")%></span></a></li>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",89,")>0 then %>
                    <li class="nav-link_yeni"><a href="#planlama_tab" onclick="onbellekten_proje_planlama_getir('<%=proje_id %>', 'planlama', this); saveGanttOnServer();" class="tabbuton icon icon-box"><span><%=LNG("Planlama")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",90,")>0 then %>
                    <li class="nav-link_yeni"><a href="#uygulama_tab" onclick="onbellekten_proje_planlama_getir('<%=proje_id %>', 'uygulama', this); saveGanttOnServer();" class="tabbuton icon icon-display"><span><%=LNG("Uygulama")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",91,")>0 then %>
                    <li class="nav-link_yeni"><a href="#satinalma_tab" onclick="onbellekten_proje_satinalma_getir('<%=proje_id %>', this);" class="tabbuton icon icon-upload"><span><%=LNG("Maliyet")%></span></a></li>
                    <% end if %>
                    <li class="nav-link_yeni" style="display:none;"><a href="#gelir_tab" onclick="onbellekten_proje_gelir_getir('<%=proje_id %>', this);" class="tabbuton icon icon-tools"><span><%=LNG("Gelir")%></span></a></li>               
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",92,")>0 then %>
                    <li class="nav-link_yeni"><a href="#ajanda_tab" onclick="onbellekten_proje_ajanda_getir('<%=proje_id %>', this);" class="tabbuton icon icon-home"><span><%=LNG("Ajanda")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",93,")>0 then %>
                    <li class="nav-link_yeni"><a href="#dosyalar_tab" onclick="onbellekten_proje_dosyalari_getir('<%=proje_id %>', this);" class="tabbuton icon icon-box"><span><%=LNG("Dosya")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",94,")>0 then %>
                    <li class="nav-link_yeni"><a href="#is_listesi_tab" onclick="onbellekten_proje_is_listesi_getir('<%=proje_id %>', this);" class="tabbuton icon icon-display"><span><%=LNG("İş Listesi")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",95,")>0 then %>
                    <li class="nav-link_yeni"><a href="#servis_tab" onclick="onbellekten_servis_getir('<%=proje_id %>', this);" class="icon icon-upload"><span><%=LNG("Bakım")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",96,")>0 then %>
                    <li class="nav-link_yeni"><a href="#adam_saat_tab" onclick="onbellekten_santiye_adam_saat_getir('<%=proje_id %>', this);" class="icon icon-upload"><span><%=LNG("Adam-Saat")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",97,")>0 then %>
                    <li class="nav-link_yeni"><a id="raporlar_tab_buton" href="#raporlar_tab" onclick="onbellekten_santiye_rapor_getir('<%=proje_id %>', this);" style="-webkit-border-top-right-radius: 10px; -webkit-border-bottom-right-radius: 10px; -moz-border-radius-topright: 10px; -moz-border-radius-bottomright: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px;" class="icon icon-tools"><span><%=LNG("Raporlar")%></span></a></li>
                    <% end if %>
                </ul>
            </nav>
            <div class="content-wrap proje_usttab">
                <section id="olaylar_tab" class="proje_tablar">
                    <script>
                                $(function (){
                                    proje_olaylar_getir('<%=proje_id %>','<%=departman_id %>');
                                });
                    </script>
                </section>
                <section id="planlama_tab" class="proje_tablar">
                </section>
                <section id="uygulama_tab" class="proje_tablar">
                </section>
              
                <section id="satinalma_tab" class="proje_tablar">
                </section>
                <section id="gelir_tab" class="proje_tablar"></section>
                
                <section id="ajanda_tab" class="proje_tablar">
                </section>
                <section id="dosyalar_tab" class="proje_tablar">
                </section>
                <section id="is_listesi_tab" class="proje_tablar">
                </section>
                <section id="servis_tab" class="proje_tablar" style="padding-top:10px;">
                  
                </section>
                
                <section id="adam_saat_tab" class="proje_tablar">
                </section>
                <section id="raporlar_tab" class="proje_tablar">
                </section>
            </div>
        </div>
    </div>
</div>
<script>
	(function() {
		[].slice.call( document.querySelectorAll( '.tabs' ) ).forEach( function( el ) {
			new CBPFWTabs( el );
		});
	})();
</script>
    
<style>
   /* .table td, .table th {
        padding: 5px !important;
    }*/
</style>
<!-- #include virtual="/ajax/include/yenidt.asp" -->
