$(document).ready(function () {




function scrollmenu() {
    if ($(window).scrollTop() >= 1) {
        $("#header ").css("z-index", "50");
    } else {
        $("#header ").css("z-index", "47");
    }
}

$(window).scroll(function () { scrollmenu(); });
$(window).resize(function () { scrollmenu(); });

// Form validationEngine
$('form#validation').validationEngine();
$('form#validation_demo').validationEngine();

// Input filter
$('.numericonly input').autotab_magic().autotab_filter('numeric');
$('.textonly input').autotab_magic().autotab_filter('text');
$('.alphaonly input').autotab_magic().autotab_filter('alpha');
$('.regexonly input').autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\.]' });
$('.alluppercase input').autotab_magic().autotab_filter({ format: 'alphanumeric', uppercase: true });

$("#slider-range-min").slider({
    range: "min",
    value: 212,
    min: 1,
    max: 700,
    slide: function (event, ui) {
        $("#amount").text("$" + ui.value);
    }
});


// Tipsy Tootip
$('.tip a ').tipsy({ gravity: 's', live: true });
$('.ntip a ').tipsy({ gravity: 'n', live: true });
$('.wtip a ').tipsy({ gravity: 'w', live: true });
$('.etip a,.Base').tipsy({ gravity: 'e', live: true });
$('.netip a ').tipsy({ gravity: 'ne', live: true });
$('.nwtip a  ').tipsy({ gravity: 'nw', live: true });
$('.swtip a,.iconmenu li a ').tipsy({ gravity: 'sw', live: true });
$('.setip a ').tipsy({ gravity: 'se', live: true });
$('.wtip input').tipsy({ trigger: 'focus', gravity: 'w', live: true });
$('.etip input').tipsy({ trigger: 'focus', gravity: 'e', live: true });
$('.iconBox, div.logout').tipsy({ gravity: 'ne', live: true });

// Maskedinput 
$.mask.definitions['~'] = "[+-]";
$("#date").mask("99/99/9999", { completed: function () { alert("completed!"); } });
$("#datepicker").datepicker().mask("99-99-9999");
$("#phone").mask("(999) 999-9999");
$("#phoneExt").mask("(999) 999-9999? x99999");
$("#iphone").mask("+33 999 999 999");
$("#tin").mask("99-9999999");
$("#ssn").mask("999-99-9999");
$("#product").mask("a*-999-a999", { placeholder: " " });
$("#eyescript").mask("~9.99 ~9.99 999");
$("#po").mask("PO: aaa-999-***");
$("#pct").mask("99%", { completed: function () { Processgraph(); } });
// Maskedinput


$("#rating_star").rating_star({
    rating_star_length: '10',
    rating_initial_value: '3'
});



// Profile webcam 
var camera = $('#camera'), screen = $('#screen');
webcam.set_api_url('upload.php');
screen.html(
		  webcam.get_html(screen.width(), screen.height())
	  );
var shootEnabled = false;
$(".takeWebcam").click(function () {
    $(".webcam").show('blind');
    return false;
});
$("#closeButton").click(function () {
    $(".webcam").hide('blind');
    return false;
});
$('#takeButton').click(function () {
    if (!shootEnabled) {
        return false;
    }
    webcam.freeze();
    togglePane()
    return false;
});
$('#retakeButton').click(function () {
    webcam.reset();
    togglePane()
    return false;
});
$('#uploadAvatar').click(function () {
    webcam.upload();
    togglePane()
    webcam.reset();
    return false;
});
webcam.set_hook('onLoad', function () {
    shootEnabled = true;
});
webcam.set_hook('onError', function (e) {
    screen.html(e);
});

$('#Textarealimit').limit('140', '.limitchars');

// placeholder text 
$('input[placeholder], textarea[placeholder]').placeholder();

// Checkbox 
$('.ck,.chkbox,.checkAll ,input:radio').customInput();

// Checkbox Limit
$('.limit3m').limitInput({ max: 3, disablelabels: true });

$(function () {
    $(' select').not("select.chzn-select,select[multiple],select#box1Storage,select#box2Storage").selectmenu({
        style: 'dropdown',
        transferClasses: true,
        width: null
    });
});

// Select boxes in Data table
$(".dataTables_wrapper .dataTables_length select").addClass("small");
$("table tbody tr td:first-child .custom-checkbox:first-child").css("margin: 0px 3px 3px 3px");

// Confirm Delete.
$(".Delete").live('click', function () {
    var row = $(this).parents('tr');
    var dataSet = $(this).parents('form');
    var id = $(this).attr("id");
    var name = $(this).attr("name");
    var data = 'id=' + id;
    Delete(data, name, row, 0, dataSet);
});


		function Delete(data,name,row,type,dataSet){
				var loadpage = dataSet.hdata(0);
				var url = dataSet.hdata(1);
				var table = dataSet.hdata(2);
				var data = data+"&tabel="+table;
		$.confirm({
		'title': '_DELETE DIALOG BOX','message': " <strong>YOU WANT TO DELETE </strong><br /><font color=red>' "+ name +" ' </font> ",'buttons': {'Yes': {'class': 'special',
		'action': function(){
					loading('Checking');
									 $('#preloader').html('Deleting...');
									 if(type==0){ row.slideUp(function(){   showSuccess('Success',5000); unloading(); }); return false;}
									  if(type==1){ row.slideUp(function(){   showSuccess('Success',5000); unloading(); }); return false;}
										setTimeout("unloading();",900); 		 
						 }},'No'	: {'class'	: ''}}});}
	  
	  

	
	// CHARTS        
    $("table.chart").each(function() {
        var colors = [];
		var height=$(this).height();
        $("table.chart thead th:not(:first)").each(function() {
            colors.push($(this).css("color"));
        });
		
        $(this).graphTable({
            series: 'columns',
            position: 'replace',
			width: '96%',
            height: '423px',
            colors: colors
        }, { xaxis: {   tickSize: 1 },
			yaxis: {
				 max: 1000,
				min:0,
            },	series: {
				points: {show: true },
                lines: { show: true, fill: true, steps: false },
			}
        });
    });
    $("table.chart2").each(function() {
        var colors = [];
        $("table.chart thead th:not(:first)").each(function() {
            colors.push($(this).css("color"));
        });
        $(this).graphTable({
            series: 'columns',  position: 'replace',width: '100%', height: '300px', colors: colors
        }, {  xaxis: {  tickSize: 1,  },
			yaxis: {
				 max: 1000,
				min:200,
            }	,	series: {
				points: {show: true },
                lines: { show: true, fill: true, steps: false },
			}
        });
    });
	$("table.chart-pie").each(function() {
        var colors = [];
        $("table.chart-pie thead th:not(:first)").each(function() {
            colors.push($(this).css("color"));
        });
        $(this).graphTable({
            series: 'columns',
            position: 'replace',
			width : '100%',
            height: '325px',
            colors: colors
        }, {
		series: {
            pie: { 
                show: true,
				innerRadius: 0.5,
                radius: 1,
				tilt: 1,
                label: {
                    show: true,
                    radius: 1,
                    formatter: function(label, series){
                        return '<div id="tooltipPie"><b>'+label+'</b> : '+Math.round(series.percent)+'%</div>';
                    },
                    background: { opacity: 0 }
                }
            }
        },
        legend: {
            show: false
        },
			grid: {
				hoverable: false,
				autoHighlight: true
			}
        });
    });
	

	$("table.chart-line").each(function() {
        var colors = [];
        $("table.chart-line thead th:not(:first)").each(function() {
            colors.push($(this).css("color"));
        });
        $(this).graphTable({
            series: 'columns', position: 'replace',width : '99%',height: '350px', colors: colors
        }, { xaxis: {  tickSize: 3 },
		series: {
				points: {show: true },
                lines: { show: true, fill: false, steps: false },
                bars: { show: false, barWidth: 0.6 },
			},
			yaxis: {
				 max: 1000,
				min:0,
            }
        });
    });
	$("table.chart-bar").each(function() {
        var colors = [];
        $("table.chart-bars thead th:not(:first)").each(function() {
            colors.push($(this).css("color"));
        });
        $(this).graphTable({
            series: 'columns',
            position: 'replace',
			width : '100%',
            height: '350px',
            colors: colors
        }, {
			xaxis: {
                tickSize: 1
            },
			series: {
				bars: {
					show: true,
					lineWidth: 1,
					barWidth: 0.7,
					fill: true,
					fillColor: null,
					align: "center",
					horizontal: false
				},
				lines: {
					show: false
				},
				points: {
					show: false
				}
			},
			yaxis: {
				max: null,
				autoscaleMargin: 0.02
            }
        });
    });


    function showTooltip(x, y, contents) {
        $('<div id="tooltip" >' + contents + '</div>').css({
            position: 'absolute',
            display: 'none',
            top: y -13,
            left: x + 10
        }).appendTo("body").show();
    }

    var previousPoint = null;
    $(".chart_flot").bind("plothover", function(event, pos, item) {
												
        $("#x").text(pos.x);
        $("#y").text(pos.y);

        if (item) {
            if (previousPoint != item.dataIndex) {
                previousPoint = item.dataIndex;

			$(this).attr('title',item.series.label);
			$(this).trigger('click');
                $("#tooltip").remove();
                var x = item.datapoint[0],
                    y = item.datapoint[1];

                showTooltip(item.pageX, item.pageY, "<b>" + item.series.label + "</b> : " + y);
            }
        }  else {
            $("#tooltip").remove();
            previousPoint = null;
        }
    });
	
	
	});		

    });