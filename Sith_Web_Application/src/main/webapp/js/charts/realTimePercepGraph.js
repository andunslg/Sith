/**
 * @author Sachintha
 */
realTimeGraph = function (eventID,perceptions) {
        var source = new EventSource('http://192.248.8.246:3000/countPeriodicPerceptions?eventID='+eventID);
        var series = new Array();
        var t = (new Date().getTime());

        for(var i=0;i<perceptions.length;i++){
            var ob = new Object();
            ob.name = perceptions[i];
            ob.data =  [
                [t - 5000, 0],
                [t - 4000, 0],
                [t - 3000, 0],
                [t - 2000, 0],
                [t - 1000, 0],
                [t, 0]
            ];
            series.push(ob);
        }
        source.onopen = function () {
            console.log('open')
        };

        source.onerror = function () {
            console.log('error');
        };

        //Event listners for page stats
        source.addEventListener('graph', updateChart, false);
        var i = 0;
        var oldVal=0;
        var newVal;
        function updateChart(event) {
            console.log(event.data);
            var data = JSON.parse(event.data);

            var chart1 = $('#LiveChart').highcharts();
            var chart2 = $('#TotLiveChart').highcharts();
            var newVal = data.total;
            var diff = newVal - oldVal;
            oldVal = newVal;

            var xval = (new Date().getTime());
            for(var i=0; i<perceptions.length; i++){
                if(!data[chart1.series[i].name]){
                    data[chart1.series[i].name] = 0
                }
                chart1.series[i].addPoint([xval, data[chart1.series[i].name]], true, true);
            }
           // chart1.series[0].addPoint([xval, data[chart1.series[0].name]], true, true);
            //chart1.series[1].addPoint([xval, data[chart1.series[1].name]], true, true);
            //chart1.series[2].addPoint([xval, data[chart1.series[2].name]], true, true);
            //chart1.series[3].addPoint([xval, data.values[3]], true, true);
            chart2.series[0].addPoint([xval, diff], true, true);
            i++;
        };

        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
        $('#LiveChart').highcharts({
            chart: {
                type: 'area',
                //animation: Highcharts.svg,
            },
            title: {
                text: 'Live Perception of Your Audience!'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 300,
                tickinterval: 3000,
                tickmarkPlacement: 'on',
                title: {
                    enabled: false
                }
            },
            yAxis: {
                title: {
                    text: 'Percent'
                }
            },
            tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.percentage:.1f}%</b> ({point.y:,.0f})<br/>',
                shared: true
            },
            plotOptions: {
                area: {
                    stacking: 'percent',
                    lineColor: '#ffffff',
                    lineWidth: 1,
                    marker: {
                        lineWidth: 1,
                        lineColor: '#ffffff'
                    }
                }
            },
            series: series
        });

        function updateChart2(event) {
            var data2 = JSON.parse(event.data);
            console.log(event.data);
            var chart2 = $('#TotLiveChart').highcharts();
            var xval2 = (new Date().getTime());
            chart2.series[0].addPoint([xval2, data2.length], true, true);
        }

        //chart drawing
        var chart;
        $('#TotLiveChart').highcharts({
            chart: {
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
            },
            title: {
                text: 'Total Perception Count'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 300,
                tickinterval: 3000,
            },
            yAxis: {
                title: {
                    text: 'Total Perception'
                },
                plotLines: [
                    {
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }
                ]
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.series.name + '</b><br/>' +
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: true
            },
            series: [
                {
                    name: 'Random data',
                    data: (function () {
                        // generate an array of random data
                        var data = [],
                            time = (new Date()).getTime(),
                            i;

                        for (i = -6; i <= 0; i++) {
                            data.push({
                                x: time + i * 1000,
                                y: 0
                            });
                        }
                        return data;
                    })()
                }
            ]
        });
};
    