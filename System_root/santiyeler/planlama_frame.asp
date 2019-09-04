<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    proje_id = trn(request("proje_id"))
    tip = trn(request("tip"))
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/js/gantt/platform.css" type="text/css">
<link rel="stylesheet" href="/js/gantt/libs/jquery/dateField/jquery.dateField.css" type="text/css">
<link rel="stylesheet" href="/js/gantt/gantt.css" type="text/css">
<link rel="stylesheet" href="/js/gantt/ganttPrint.css" type="text/css" media="print">
<script src="/js/gantt/libs/jquery/jquery.livequery.1.1.1.min.js"></script>
<script src="/js/gantt/libs/jquery/jquery.timers.js"></script>
<script src="/js/gantt/libs/utilities.js"></script>
<script src="/js/gantt/libs/forms.js"></script>
<script src="/js/gantt/libs/date.js"></script>
<script src="/js/gantt/libs/dialogs.js"></script>
<script src="/js/gantt/libs/layout.js"></script>
<script src="/js/gantt/libs/i18nJs.js"></script>
<script src="/js/gantt/libs/jquery/dateField/jquery.dateField.js"></script>
<script src="/js/gantt/libs/jquery/JST/jquery.JST.js"></script>
<script type="text/javascript" src="/js/gantt/libs/jquery/svg/jquery.svg.min.js"></script>
<script type="text/javascript" src="/js/gantt/libs/jquery/svg/jquery.svgdom.1.8.js"></script>
<script src="/js/gantt/ganttUtilities.js"></script>
<script src="/js/gantt/ganttTask.js"></script>
<script src="/js/gantt/ganttDrawerSVG.js"></script>
<script src="/js/gantt/ganttZoom.js"></script>
<script src="/js/gantt/ganttGridEditor.js"></script>
<script src="/js/gantt/ganttMaster.js"></script>
<script src="/js/plugin/masked-input/jquery.maskedinput.min.js"></script>
<script src="/js/plugin/select2/select2.min.js"></script>
<link rel="stylesheet" href="/files/assets/css/style.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="/files/assets/icon/font-awesome/css/font-awesome.min.css">
<div id="workSpace" style="padding: 0px; overflow-y: auto; overflow-x: hidden; position: relative; margin: 0 5px"></div>
<style>

    .bwinPopupd {
        margin-top:0!important;
    }

    .taskBoxGolge {
        opacity: 0.2;
    }


    .splitBox1 {
        width: 30%;
    }

    .splitBox2 {
        width: 70%;
        /* overflow:hidden!important;  */
    }

    .gantt {
        float: left;
        position: relative;
    }

    .resEdit {
        padding: 15px;
    }

    .resLine {
        width: 95%;
        padding: 3px;
        margin: 5px;
        border: 1px solid #d0d0d0;
    }

    body {
        overflow: hidden;
        background-color: white;
    }

    .ganttButtonBar h1 {
        color: #000000;
        font-weight: bold;
        font-size: 28px;
        margin-left: 10px;
    }

    .yeni_button1 {
        color: white;
        border-radius: 2rem;
        font-size: 14px;
        background-color: #2ed8b6;
        border-color: #2ed8b6;
        color: #fff;
        cursor: pointer;
        -webkit-transition: all ease-in 0.3s;
        transition: all ease-in 0.3s;
        display: inline-block;
        font-weight: 400;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        border: 1px solid transparent;
        padding: .5rem .75rem;
        /* font-size: 1rem; */
        line-height: 1.25;
        border-radius: .25rem;
        transition: all .15s ease-in-out;
        text-transform: capitalize;
        border-radius: 2rem;
        padding-left: 15px;
        padding-right: 15px;
    }

    .yeni_button2 {
        color: white;
        border-radius: 2rem;
        font-size: 14px;
        background-color: #222;
        border-color: #222;
        color: #fff;
        cursor: pointer;
        -webkit-transition: all ease-in 0.3s;
        transition: all ease-in 0.3s;
        display: inline-block;
        font-weight: 400;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        border: 1px solid transparent;
        padding: .5rem .75rem;
        /* font-size: 1rem; */
        line-height: 1.25;
        border-radius: .25rem;
        transition: all .15s ease-in-out;
        text-transform: capitalize;
        border-radius: 2rem;
        padding-left: 15px;
        padding-right: 15px;
    }


    b[role=presentation] {
        padding-top: 10px;
    }
</style>

<form id="gimmeBack" style="display: none;" action="/ajax_timeline/" method="post" target="_blank">
    <input type="hidden" name="prj" id="gimBaPrj"></form>

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

        var asd = loadGanttFromServer('<%=proje_id %>');


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

        //var currentDate = new Date();  
        //$("#start").datepicker("setDate",currentDate);
        //$("#end").datepicker("setDate", currentDate);


        $.getJSON("/ajax_planlama/?jsid=4559&tip=<%=request("tip")%>&proje_id=<%=request("proje_id")%>", { CM: "LOADPROJECT", taskId: taskId }, function (response) {
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
        var planning = "0"; 
        console.log(JSON.stringify(prj));

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
            data: { islem: "kayit", tip: "<%=tip%>", proje_id: "<%=request("proje_id")%>", prj: JSON.stringify(prj), planning: planning },
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

    function ajandada_goster() {

        
        if ($("#planning").attr("checked") === "checked") { 
             planning = "1";
        }
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

<div id="gantEditorTemplates" style="display: none;">
    <div class="__template__" type="GANTBUTTONS">
        <!--
            <div class="ganttButtonBar noprint">
            <div class="buttons">
                <button onclick="parent.uretim_sablonlarindan_secim_yap('<%=proje_id %>');" class="button requireWrite" title="edit resources"><i class="fa fa-clone"></i> <%=LNG("Üretim Şablonlarından Seç")%></button>
                <button onclick="parent.proje_plan_kopyala('<%=proje_id %>');" class="button requireWrite" title="edit resources"><i class="fa fa-clone"></i> <%=LNG("Planı Kopyala")%></button>
                <button onclick="parent.proje_sablonlara_kaydet('<%=proje_id %>');" class="button requireWrite" title="edit resources"><i class="fa fa-clone"></i> <%=LNG("Şablonlara Kaydet")%></button>
            </div>
              <div class="buttons" style="height:auto;">
                <button onclick="$('#workSpace').trigger('undo.gantt');return false;" class="button textual icon requireCanWrite" title="<%=LNG("Geri Al")%>"><span class="teamworkIcon">&#39;</span></button>
                <button onclick="$('#workSpace').trigger('redo.gantt');return false;" class="button textual icon requireCanWrite" title="<%=LNG("İleri Al")%>"><span class="teamworkIcon">&middot;</span></button>
                <span class="ganttButtonSeparator requireCanWrite requireCanAdd"></span>
                <button onclick="$('#workSpace').trigger('addAboveCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanAdd" title="<%=LNG("Üstüne Ekle")%>"><span class="teamworkIcon">l</span></button>
                <button onclick="$('#workSpace').trigger('addBelowCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanAdd" title="<%=LNG("Altına Ekle")%>"><span class="teamworkIcon">X</span></button>
                <span class="ganttButtonSeparator requireCanWrite requireCanInOutdent"></span>
                <button onclick="$('#workSpace').trigger('outdentCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanInOutdent" title="<%=LNG("Dışarı Çıkar")%>"><span class="teamworkIcon">.</span></button>
                <button onclick="$('#workSpace').trigger('indentCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanInOutdent" title="<%=LNG("İçeri Al")%>"><span class="teamworkIcon">:</span></button>
                <span class="ganttButtonSeparator requireCanWrite requireCanMoveUpDown"></span>
                <button onclick="$('#workSpace').trigger('moveUpCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanMoveUpDown" title="<%=LNG("Yukarı Taşı")%>"><span class="teamworkIcon">k</span></button>
                <button onclick="$('#workSpace').trigger('moveDownCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanMoveUpDown" title="<%=LNG("Aşağı Taşı")%>"><span class="teamworkIcon">j</span></button>
                <span class="ganttButtonSeparator requireCanWrite requireCanDelete"></span>
                <button onclick="$('#workSpace').trigger('deleteFocused.gantt');return false;" class="button textual icon delete requireCanWrite" title="<%=LNG("Sil")%>"><span class="teamworkIcon">&cent;</span></button>
                <span class="ganttButtonSeparator"></span>
                <button onclick="$('#workSpace').trigger('expandAll.gantt');return false;" class="button textual icon " title="<%=LNG("Tümünü Genişlet")%>"><span class="teamworkIcon">6</span></button>
                <button onclick="$('#workSpace').trigger('collapseAll.gantt'); return false;" class="button textual icon " title="<%=LNG("Tümünü Darat")%>"><span class="teamworkIcon">5</span></button>

              <span class="ganttButtonSeparator"></span>
                <button onclick="$('#workSpace').trigger('zoomMinus.gantt'); return false;" class="button textual icon" title="Uzaklaştır"><span class="teamworkIcon">)</span></button>
                <button onclick="$('#workSpace').trigger('zoomPlus.gantt');return false;" class="button textual icon " title="Yakınlaştır"><span class="teamworkIcon">(</span></button>
              <span style="display:none;" class="ganttButtonSeparator"></span>
                <button style="display:none;" onclicks="$('#workSpace').trigger('print.gantt');return false;" class="button textual icon " title="<%=LNG("Yazdır")%>"><span class="teamworkIcon">p</span></button>
              <span class="ganttButtonSeparator"></span>
                <button style="display:none;" onclick="ge.gantt.showCriticalPath=!ge.gantt.showCriticalPath; ge.redraw();return false;" class="button textual icon requireCanSeeCriticalPath" title="CRITICAL_PATH"><span class="teamworkIcon">&pound;</span></button>
              <span style="display:none;" class="ganttButtonSeparator requireCanSeeCriticalPath"></span>
                <button onclick="ge.splitter.resize(.1);return false;" class="button textual icon" ><span class="teamworkIcon">F</span></button>
                <button onclick="ge.splitter.resize(50);return false;" class="button textual icon" ><span class="teamworkIcon">O</span></button>
                <button onclick="ge.splitter.resize(100);return false;" class="button textual icon"><span class="teamworkIcon">R</span></button>
                <span class="ganttButtonSeparator"></span>
                <button style="display:none;" onclick="$('#workSpace').trigger('fullScreen.gantt');return false;" class="button textual icon" title="FULLSCREEN" id="fullscrbtn"><span class="teamworkIcon">@</span></button>
                <button style="display:none;" onclick="ge.element.toggleClass('colorByStatus' );return false;" class="button textual icon"><span class="teamworkIcon">&sect;</span></button>

              <button onclick="parent.gantt_liste_gorunumu('<%=proje_id %>', '<%=tip %>');"  style="background-color:#f9c154;" class="button  requireWrite" title="edit resources"><i class="fa fa-reorder"></i> <%=LNG("Liste")%></button>
              <button onclick="parent.is_yuku_cizelgesi_ac('<%=cdate(date)-2 %>', '<%=cdate(date)-1 %>');" style="background-color:#f9c154;" class="button requireWrite" title="edit resources"><i class="fa fa-cubes"></i> <%=LNG("İş Yükü")%></button>

              <div style="width:160px; float:left; margin-top:12px;"><label style="cursor:pointer;" for="karsilastirmali_gosterim"><input name="karsilastirmali_gosterim" onclick="karsilastirmali_gosterim_calistir(this);" id="karsilastirmali_gosterim" type="checkbox"> <%=LNG("Karşılaştırmalı Gösterim")%></span></div>
              <button onclick="editResources();" style="display:none;" class="button textual requireWrite" title="edit resources"><span class="teamworkIcon">M</span></button>
              <div style="float:right;">
                  <button onclick="saveGanttOnServer();" class="button" style="background-color: #2ed8b6;" title="<%=LNG("Değişiklikleri Kaydet")%>"><%=LNG("Değişiklikleri Kaydet")%></button>
                  <button onclick='newProject();' class='button' style="background-color: #ff5370;"><em><%=LNG("Sıfırla")%></em></button>
              </div>
                <div style="display:none;">
                  <button class="button login" title="login/enroll" onclick="loginEnroll($(this));" style="display:none;">login/enroll</button>
                  <button class="button opt collab" title="Start with Twproject" onclick="collaborate($(this));" style="display:none;"><em>collaborate</em></button>
                </div>
              </div>
            </div>
            -->
    </div>
    
    <div class="__template__" type="TASKSEDITHEAD">
        <!--
            <table class="gdfTable" cellspacing="0" cellpadding="0">
              <thead>
              <tr style="height:40px">
                <th class="gdfColHeader" style="width:35px; border-right: none"></th>
                <th class="gdfColHeader" style="width:25px;"></th>
                <th class="gdfColHeader gdfResizable" style="width:100px; display:none;"><%=LNG("Kısakod")%></th>
                <th class="gdfColHeader gdfResizable" style="width:300px; text-align:left;"><%=LNG("Adı")%></th>
                <th class="gdfColHeader"  align="center" style="width:17px; display:none;" title="<%=LNG("Başlangıç Çizgisi.")%>"><span class="teamworkIcon" style="font-size: 8px;">^</span></th>
                <th class="gdfColHeader gdfResizable" style="width:80px;"><%=LNG("Başlangıç")%></th>
                <th class="gdfColHeader"  align="center" style="width:17px; display:none;" title="<%=LNG("Bitiş Çizgisi.")%>"><span class="teamworkIcon" style="font-size: 8px;">^</span></th>
                <th class="gdfColHeader gdfResizable" style="width:80px;"><%=LNG("Bitiş")%></th>
                <th class="gdfColHeader gdfResizable" style="width:50px;"><%=LNG("Gün")%></th>
                <th class="gdfColHeader gdfResizable" style="width:20px;">%</th>
                <th class="gdfColHeader gdfResizable requireCanSeeDep" style="width:30px;;"><%=LNG("Bağlantı / Atlama")%></th>
                <th class="gdfColHeader gdfResizable" style="width:1000px; text-align: left; padding-left: 10px;"><%=LNG("Kaynaklar")%></th>
              </tr>
              </thead>
            </table>
            -->
    </div>

    <div class="__template__" type="TASKROW">
        <!--
    <tr id="tid_(#=obj.id#)" taskId="(#=obj.id#)" class="taskEditRow (#=obj.isParent()?'isParent':''#) (#=obj.collapsed?'collapsed':''#)" level="(#=level#)">
      <th class="gdfCell edit" align="right" style="cursor:pointer;"><span class="taskRowIndex">(#=obj.getRow()+1#)</span> <span class="teamworkIcon" style="font-size:12px;" >e</span></th>
      <td class="gdfCell noClip" align="center"><div class="taskStatus cvcColorSquare" status="(#=obj.status#)"></div></td>
      <td class="gdfCell" style="display:none;"><input type="text" name="code" value="(#=obj.code?obj.code:''#)" placeholder="<%=LNG("Kısakod")%>"></td>
      <td class="gdfCell indentCell" style="padding-left:(#=obj.level*10+18#)px;">
        <div class="exp-controller" align="center"></div>
        <input type="text" name="name" value="(#=obj.name#)" placeholder="<%=LNG("Adı")%>">
      </td>
      <td class="gdfCell" align="center" style="display:none;"><input type="checkbox" name="startIsMilestone"></td>
      <td class="gdfCell"><input type="text" name="start" value="" class="date"></td>
      <td class="gdfCell" align="center" style="display:none;"><input type="checkbox" name="endIsMilestone"></td>
      <td class="gdfCell"><input type="text" name="end" value="" class="date"></td>
      <td class="gdfCell" style="text-align:center;"><input style="text-align:center;" type="text" name="duration" autocomplete="off" value="(#=obj.duration#)"></td>
      <td class="gdfCell"><input type="text" name="progress" class="validated" entrytype="PERCENTILE" autocomplete="off" value="(#=obj.progress?obj.progress:''#)" (#=obj.progressByWorklog?"readOnly":""#)></td>
      <td class="gdfCell requireCanSeeDep"><input type="text" name="depends" autocomplete="off" value="(#=obj.depends#)" (#=obj.hasExternalDep?"readonly":""#)></td>
      <td class="gdfCell taskAssigs">(#=obj.getAssigsString()#)</td>
    </tr>
    -->
    </div>

    <div class="__template__" type="TASKEMPTYROW">
        <!--
            <tr class="taskEditRow emptyRow" >
              <th class="gdfCell" align="right"></th>
              <td class="gdfCell noClip" align="center"></td>
              <td class="gdfCell" style="display:none;"></td>
              <td class="gdfCell"></td>
              <td class="gdfCell"></td>
              <td class="gdfCell"></td>
              <td class="gdfCell"></td>
              <td class="gdfCell"></td>
              <td class="gdfCell"></td>
              <td class="gdfCell"></td>
              <td class="gdfCell requireCanSeeDep"></td>
              <td class="gdfCell"></td>
            </tr>
            -->
    </div>

    <div class="__template__" type="TASKBAR">
        <!--
            <div class="taskBox taskBoxDiv" taskId="(#=obj.id#)" >
              <div class="layout (#=obj.hasExternalDep?'extDep':''#)">
                <div class="taskStatus" status="(#=obj.status#)"></div>
                <div class="taskProgress" style="width:(#=obj.progress>100?100:obj.progress#)%; background-color:(#=obj.progress>100?'red':'rgb(153,255,51);'#);"></div>
                <div class="milestone (#=obj.startIsMilestone?'active':''#)" ></div>

                <div class="taskLabel"></div>
                <div class="milestone end (#=obj.endIsMilestone?'active':''#)" ></div>
              </div>
            </div>
            -->
    </div>


    <div class="__template__" type="CHANGE_STATUS">
        <!--
              <div class="taskStatusBox">
              <div class="taskStatus cvcColorSquare" status="STATUS_ACTIVE" title="<%=LNG("Aktif")%>"></div>
              <div class="taskStatus cvcColorSquare" status="STATUS_DONE" title="<%=LNG("Tamamlandı")%>"></div>
              <div class="taskStatus cvcColorSquare" status="STATUS_FAILED" title="<%=LNG("Hatalı")%>"></div>
              <div class="taskStatus cvcColorSquare" status="STATUS_SUSPENDED" title="<%=LNG("Duraklatıldı")%>"></div>
              <div class="taskStatus cvcColorSquare" status="STATUS_WAITING" title="<%=LNG("Bekliyor")%>" style="display: none;"></div>
              <div class="taskStatus cvcColorSquare" status="STATUS_UNDEFINED" title="<%=LNG("Diğer")%>"></div>
              </div>
            -->
    </div>




    <div class="__template__" type="TASK_EDITOR">
        <!--
    <div class="ganttTaskEditor">
      <h2 class="taskData" style="font-size:16px;"><%=LNG("İşlem Detayları")%></h2>
      <table  cellspacing="1" cellpadding="5" width="100%" class="taskData" border="0">
            <tr>
          <td width="200" style="height: 80px; display:none;"  valign="top">
            <label for="code"><%=LNG("Kısakod")%></label><br>
            <input type="text" name="code" id="code" value="" size=15 class="form-control" autocomplete='off' maxlength=255 style='width:100%' oldvalue="1">
          </td>
          <td colspan="3" valign="top"><label for="name" class="required">Adı</label><br><input type="text" name="name" id="name" class="form-control" autocomplete='off' maxlength=255 style='width:100%' value="" required="true" oldvalue="1"></td>
            </tr>


        <tr class="dateRow">
          <td nowrap="">
            <div style="position:relative">
              <label for="<%=LNG("Başlangıç")%>"><%=LNG("Başlangıç")%></label>&nbsp;&nbsp;&nbsp;&nbsp;
              <input style="display:none;" type="checkbox" id="startIsMilestone" name="startIsMilestone" value="yes"> &nbsp;<label style="display:none;" for="startIsMilestone"><%=LNG("Kilometre Taşı")%></label>&nbsp;
              <br><input type="text" name="start" id="start" size="8" class="form-control dateField validated date" autocomplete="off" maxlength="255" value="04.23.2014" oldvalue="1" entrytype="DATE">
              <span title="calendar" id="starts_inputDate" class="teamworkIcon openCalendar" onclick="$(this).dateField({inputField:$(this).prevAll(':input:first'),isSearchField:false});">m</span>          </div>
          </td>
          <td nowrap="">
            <label for="end"><%=LNG("Bitiş")%></label>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="checkbox" style=display:none; id="endIsMilestone" name="endIsMilestone" value="yes">&nbsp;<label style="display:none;" for="endIsMilestone"><%=LNG("Kilometre Taşı")%></label>&nbsp;
            <br><input type="text" name="end" id="end" size="8" class="form-control dateField validated date" autocomplete="off" maxlength="255" value="04.23.2014" oldvalue="1" entrytype="DATE">
            <span title="calendar" id="ends_inputDate" class="teamworkIcon openCalendar" onclick="$(this).dateField({inputField:$(this).prevAll(':input:first'),isSearchField:false});">m</span>
          </td>
          <td nowrap="" >
            <label for="duration" class=" "><%=LNG("Süre(Gün)")%></label><br>
            <input type="text" name="duration" onchange="gantt_detaydan_tarih_degisti();" id="duration" size="4" class="form-control validated durationdays" title="<%=LNG("Süre gün cinsinden girilmelidir.")%>" autocomplete="off" maxlength="255" value="" oldvalue="1" entrytype="DURATIONDAYS">&nbsp;
          </td>
        </tr>

        <tr>
          <td  colspan="2">
            <label for="status" class=" "><%=LNG("Durum")%></label><br>
            <select id="status" name="status" class="taskStatus" status="(#=obj.status#)"  onchange="$(this).attr('STATUS',$(this).val());">
              <option value="STATUS_ACTIVE" class="taskStatus" status="STATUS_ACTIVE" ><%=LNG("Aktif")%></option>
              <option value="STATUS_WAITING" class="taskStatus" status="STATUS_WAITING" ><%=LNG("Bekliyor")%></option>
              <option value="STATUS_SUSPENDED" class="taskStatus" status="STATUS_SUSPENDED" ><%=LNG("Duraklatıldı")%></option>
              <option value="STATUS_DONE" class="taskStatus" status="STATUS_DONE" ><%=LNG("Tamamlandı")%></option>
              <option value="STATUS_FAILED" class="taskStatus" status="STATUS_FAILED" ><%=LNG("Hatalı")%></option>
              <option value="STATUS_UNDEFINED" class="taskStatus" status="STATUS_UNDEFINED" ><%=LNG("Diğer")%></option>
            </select>
          </td>

          <td valign="top" nowrap>
            <label><%=LNG("İlerleme(%)")%></label><br>
            <input type="text" name="progress" id="progress" size="7" class="form-control validated percentile" autocomplete="off" maxlength="255" value="" oldvalue="1" entrytype="PERCENTILE">
          </td>
        </tr>

            </tr>
            <tr>
              <td colspan="4">
                <label for="description"><%=LNG("Açıklama")%></label><br>
                <textarea rows="3" cols="30" id="description" name="description" class="form-control" style="width:100%"></textarea>
              </td>
            </tr>
          </table>

        <div style="display:nones;">
            <br>
            <h2><%=LNG("Kaynaklar")%><a class="button requireWrite" onclick="javascript:is_yuku_cizelgesi_ac2();" style="float:right; cursor:pointer; font-size:12px; padding-top:10px;"><%=LNG("Kaynak İş Yükü Çizelgesi")%><a></h2>
            
            <table  cellspacing="1" cellpadding="0" width="100%" id="assigsTable">
                <tr>
                <th><%=LNG("Adı")%></th>
                <th style="width:70px; display:none;"><%=LNG("Rol")%></th>
                <th style="width:120px; text-align:center;"><%=LNG("Günlük Ort. Çalışma(saat)")%></th>
                <th style="width:60px; text-align:center;"><%=LNG("Toplam Çalışma(saat)")%></th>
                <th style="width:45px; text-align:center;" id="addAssig"><span class="teamworkIcon" style="cursor: pointer">+</span></th>
                </tr>
            </table>
        </div>

    <div style="text-align: right; padding-top: 20px">
      <span id="saveButton" class="button first" onClick="$(this).trigger('saveFullEditor.gantt');"><%=LNG("Kaydet ")%></span>
    </div>
    </div>
    -->
    </div>
    <div class="__template__" type="ASSIGNMENT_ROW">
            <!--
        <tr taskId="(#=obj.task.id#)" assId="(#=obj.assig.id#)" class="assigEditRow" >
          <td style="width:50%;"><select style="width:100%;" name="resourceId"  class="form-control select2 resourceId" ></select></td>
          <td style="display:none;" ><select type="select" name="roleId" class="form-control"></select></td>
          <td style="text-align:center;"><input type="text" onkeyup="gunluk_calisma_girdim(this);" taskId="(#=obj.task.id#)" assId="(#=obj.assig.id#)" class="gunluk_calisma" name="gunluk_calisma" value="(#=getMillisInHours((parseFloat(obj.assig.effort) || 0) / parseFloat(obj.task.duration) || 0)#)" size="5" class="form-control timepicker"> X<span class="gunsayisi"> (#=obj.task.duration#) gün<span></td>
          <td style="text-align:center;"><input onkeyup="toplam_calisma_girdim(this);" type="text" taskId="(#=obj.task.id#)" assId="(#=obj.assig.id#)" name="effort" value="(#=getMillisInHoursMinutes(obj.assig.effort)#)" size="5" class="form-control timepicker"></td>
          <td align="center"><span class="teamworkIcon delAssig del" style="cursor: pointer">d</span></td>
        </tr>
        -->
    </div>

    <div class="__template__" type="RESOURCE_EDITOR">
        <!--
            <div class="resourceEditor" style="padding: 5px;">
              <h2><%=LNG("Proje Takımı")%></h2>
              <table  cellspacing="1" cellpadding="0" width="100%" id="resourcesTable">
                <tr>
                  <th style="width:100px;"><%=LNG("Adı")%></th>
                  <th style="width:30px;" id="addResource"><span class="teamworkIcon" style="cursor: pointer">+</span></th>
                </tr>
              </table>
              <div style="text-align: right; padding-top: 20px"><button id="resSaveButton" class="button big"><%=LNG("Kaydet")%></button></div>
            </div>
            -->
    </div>

    <div class="__template__" type="RESOURCE_ROW">
        <!--
    <tr resId="(#=obj.id#)" class="resRow" >
      <td ><input type="text" name="name" value="(#=obj.name#)" style="width:100%;" class="form-control"></td>
      <td align="center"><span class="teamworkIcon delRes del" style="cursor: pointer">d</span></td>
    </tr>
    -->
    </div>


</div>
<script type="text/javascript">

    $.JST.loadDecorator("RESOURCE_ROW", function (resTr, res) {
        resTr.find(".delRes").click(function () { $(this).closest("tr").remove() });
    });

    $.JST.loadDecorator("ASSIGNMENT_ROW", function (assigTr, taskAssig) {
        var resEl = assigTr.find("[name=resourceId]");
        var opt = $('<option>');
        resEl.append(opt);
        for (var i = 0; i < taskAssig.task.master.resources.length; i++) {
            var res = taskAssig.task.master.resources[i];
            opt = $('<option optiongroup="' + res.tip + '">');
            opt.val(res.id).html(res.name);
            if (taskAssig.assig.resourceId == res.id)
                opt.attr("selected", "true");
            resEl.append(opt);
        }
        var roleEl = assigTr.find("[name=roleId]");
        for (var i = 0; i < taskAssig.task.master.roles.length; i++) {
            var role = taskAssig.task.master.roles[i];
            var optr = $('<option optiongroup="' + res.tip + '">');
            optr.val(role.id).html(role.name);
            if (taskAssig.assig.roleId == role.id)
                optr.attr("selected", "true");
            roleEl.append(optr);
        }

        if (taskAssig.task.master.permissions.canWrite && taskAssig.task.canWrite) {
            assigTr.find(".delAssig").click(function () {
                var tr = $(this).closest("[assId]").fadeOut(200, function () { $(this).remove() });
            });
        }

    });


    function loadI18n() {
        GanttMaster.messages = {
            "CANNOT_WRITE": "<%=LNG("Görevi değiştirmek için izniniz yok")%>:",
            "CHANGE_OUT_OF_SCOPE": "<%=LNG("Bir ana projeyi güncelleme haklarınız olmadığı için proje güncellemesi mümkün değildir.")%>",
            "START_IS_MILESTONE": "<%=LNG("Başlangıç ​​tarihi bir kilometre taşıdır.")%>",
            "END_IS_MILESTONE": "<%=LNG("Bitiş tarihi bir kilometre taşıdır.")%>",
            "TASK_HAS_CONSTRAINTS": "<%=LNG("Görevde kısıtlamalar var.")%>",
            "GANTT_ERROR_DEPENDS_ON_OPEN_TASK": "<%=LNG("Hata: Açık bir göreve bağımlılık var.")%>",
            "GANTT_ERROR_DESCENDANT_OF_CLOSED_TASK": "<%=LNG("Hata: kapalı bir görevin soyundan dolayı işlem yapılamaz.")%>",
            "TASK_HAS_EXTERNAL_DEPS": "<%=LNG("Bu görevde dış bağımlılıklar var.")%>",
            "GANNT_ERROR_LOADING_DATA_TASK_REMOVED": "GANNT_ERROR_LOADING_DATA_TASK_REMOVED",
            "CIRCULAR_REFERENCE": "<%=LNG("Dairesel referans.")%>",
            "CANNOT_DEPENDS_ON_ANCESTORS": "<%=LNG("Atalara bağlı olamaz.")%>",
            "INVALID_DATE_FORMAT": "<%=LNG("Eklenen veriler alan formatı için geçersiz.")%>",
            "GANTT_ERROR_LOADING_DATA_TASK_REMOVED": "<%=LNG("Veriler yüklenirken bir hata oluştu. Bir görev atıldı.")%>",
            "CANNOT_CLOSE_TASK_IF_OPEN_ISSUE": "<%=LNG("Açık sorunları olan bir görev kapatılamıyor")%>",
            "TASK_MOVE_INCONSISTENT_LEVEL": "<%=LNG("Farklı derinlikteki görevleri değiştiremezsiniz.")%>",
            "CANNOT_MOVE_TASK": "<%=LNG("İş Adımı taşınamaz.")%>",
            "PLEASE_SAVE_PROJECT": "<%=LNG("Lütfen Projeyi Kaydedin")%>",
            "GANTT_SEMESTER": "<%=LNG("Dönem")%>",
            "GANTT_SEMESTER_SHORT": "s.",
            "GANTT_QUARTER": "<%=LNG("Çeyrek")%>",
            "GANTT_QUARTER_SHORT": "q.",
            "GANTT_WEEK": "<%=LNG("Hafta")%>",
            "GANTT_WEEK_SHORT": "w."
        };
    }



    function createNewResource(el) {
        var row = el.closest("tr[taskid]");
        var name = row.find("[name=resourceId_txt]").val();
        var url = contextPath + "/applications/teamwork/resource/resourceNew.jsp?CM=ADD&name=" + encodeURI(name);

        openBlackPopup(url, 700, 320, function (response) {
            //fillare lo smart combo
            if (response && response.resId && response.resName) {
                //fillare lo smart combo e chiudere l'editor
                row.find("[name=resourceId]").val(response.resId);
                row.find("[name=resourceId_txt]").val(response.resName).focus().blur();
            }

        });
    }
</script >


