<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    proje_id = trn(request("id"))
    departman_id = trn(request("departman_id"))

%>
<html>
<head>
    <meta name='viewport' id="viewport" content='width=device-width,initial-scale=1,user-scalable=no' />
    <meta name='format-detection' content="telephone=yes" />
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans|Roboto|Dosis">
    <link href="/js/excell/excellstyle.css" rel="stylesheet" />
    <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
    <script src="/js/excell/dist/js/jquery.jexcel.js"></script>
    <script src="/js/excell/dist/js/jquery.jcalendar.js"></script>
    <link rel="stylesheet" href="/js/excell/dist/css/jquery.jexcel.css" type="text/css" />
    <link rel="stylesheet" href="/js/excell/dist/css/jquery.jcalendar.css" type="text/css" />
</head>
<body>
    <div class='container'>
        <div class="title" style="font-size: 15px;"><%=LNG("Adam-Saat Cetveli")%></div>
        <br />
        <div id="my"></div>
        <br />
        <br />
        <div id="container"></div>
        <script>
            var data = [
                ['Salih ŞAHİN', 7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6, 7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6],
                ['Kadir DAĞCI', -0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5, -0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5],
                ['Safa ORAKÇI', -0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0, -0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0],
                ['Cem HELİMOĞLU', 3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8, 3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8],
                ['Taşeron 1', 3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8, 3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8],
                ['Taşeron 2', 3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8, 3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8],
                ['<strong>TOPLAM</strong>', 13.9, 14.2, 15.7, 18.5, 111.9, 115.2, 117.0, 116.6, 114.2, 110.3, 16.6, 14.8, 13.9, 14.2, 15.7, 18.5, 111.9, 115.2, 117.0, 116.6, 114.2, 110.3, 16.6, 14.8],
                ['<strong>MALİYET</strong>', 213.9, 114.2, 115.7, 218.5, 2111.9, 3115.2, 4117.0, 5116.6, 6114.2, 7110.3, 216.6, 214.8, 213.9, 332.2, 115.7, 118.5, 2111.9, 2115.2, 2117.0, 2116.6, 2114.2, 2110.3, 216.6, 214.8],
            ];

            var update = function (obj, cel, val) {
                // Get the cell position x, y
                var id = $(cel).prop('id').split('-');
                // If the related series does not exists create a new one
                if (!chart.series[id[1]]) {
                    // Create a new series row
                    var row = [];
                    for (i = 1; i < data[id[1]].length; i++) {
                        row.push(parseFloat(data[id[1]][i]));
                    }
                    // Append new series to the chart
                    chart.addSeries({ name: data[id[1]][0], data: row });
                } else {
                    // Update the value from the chart
                    chart.series[id[1]].data[id[0] - 1].update({ y: parseFloat(val) });
                }
            }

            $('#my').jexcel({
                data: data,
                onchange: update,
                colHeaders: ['ÇALIŞANLAR', '01.01.2018', '02.01.2018', '03.01.2018', '04.01.2018', '05.01.2018', '06.01.2018', '07.01.2018', '08.01.2018', '09.01.2018', '10.01.2018', '11.01.2018', '12.01.2018', '13.01.2018', '14.01.2018', '15.01.2018', '16.01.2018', '17.01.2018', '18.01.2018', '19.01.2018', '20.01.2018', '21.01.2018', '22.01.2018', '23.01.2018', '24.01.2018'],
                colWidths: [300, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85],
                columns: [

                ]
            });

            // Kepp it global
            var chart = null;

            $(function () {
            /*
            
Highcharts.chart('container', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Monthly Average Rainfall'
    },
    subtitle: {
        text: 'Source: WorldClimate.com'
    },
    xAxis: {
        categories: [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec'
        ],
        crosshair: true
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Rainfall (mm)'
        }
    },
    tooltip: {
        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
    },
    plotOptions: {
        column: {
            pointPadding: 0.2,
            borderWidth: 0
        }
    },
    series: [{
        name: 'Tokyo',
        data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]

    }, {
        name: 'New York',
        data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3]

    }, {
        name: 'London',
        data: [48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2]

    }, {
        name: 'Berlin',
        data: [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1]

    }]
});
            */

                chart = Highcharts.chart('container', {
            chart: {
        type: 'column'
    },
                    title: {
                        text: 'Emek 23 Sitesi',
                        x: -20 //center
                    },
                    subtitle: {
                        text: 'Adam Saat Cetveli',
                        x: -20
                    },
                    xAxis: {
                        categories: ['01.01.2018', '02.01.2018', '03.01.2018', '04.01.2018', '05.01.2018', '06.01.2018', '07.01.2018', '08.01.2018', '09.01.2018', '10.01.2018', '11.01.2018', '12.01.2018', '13.01.2018', '14.01.2018', '15.01.2018', '16.01.2018', '17.01.2018', '18.01.2018']
                    },
                    yAxis: {
                        title: {
                            text: 'Adam-Saat'
                        },
                        plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                    },
                    tooltip: {
                        valueSuffix: ' saat'
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle',
                        borderWidth: 0
                    },
                    series: [{
                        name: 'Salih ŞAHİN',
                        data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
                    }, {
                            name: 'Kadir DAĞCI',
                        data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
                    }, {
                            name: 'Safa ORAKÇI',
                        data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
                        }, {
                            name: 'Cem HELİMOĞLU',
                            data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
                        }, {
                            name: 'Taşeron 1',
                            data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
                        }, {
                            name: 'Taşeron 2',
                            data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
                        }]
                });
            });
        </script>


    </div>

</body>
</html>
