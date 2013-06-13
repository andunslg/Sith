/**
 * @author Sachintha
 */
$(function () {
    $(document).ready(function () {
        var source = new EventSource('http://localhost:3000/countPeriodicPerceptions?eventID=cse_pc1');
        var t = (new Date().getTime());
        source.onopen = function () {
            console.log('open')
        };

        source.onerror = function () {
            console.log('error');
        };

        //Event listners for page stats
        source.addEventListener('graph', updateChart, false);
        var i = 0;
        var oldVal;

        function updateChart(event) {
            var data = JSON.parse(event.data);
            //console.log(event.data);
            var chart1 = $('#LiveChart').highcharts();
            var chart2 = $('#TotLiveChart').highcharts();
            var newVal = data.values[4];
            if (i == 0) {
                oldVal = newVal;
            }
            var diff = newVal - oldVal;
            if (i != 0) {
                oldVal = newVal;
            }
            var xval = (new Date().getTime());
            chart1.series[0].addPoint([xval, data.values[0]], true, true);
            chart1.series[1].addPoint([xval, data.values[1]], true, true);
            chart1.series[2].addPoint([xval, data.values[2]], true, true);
            chart1.series[3].addPoint([xval, data.values[3]], true, true);
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
            series: [
                {
                    name: 'Interested',
                    data: [
                        [t - 5000, 0],
                        [t - 4000, 0],
                        [t - 3000, 0],
                        [t - 2000, 0],
                        [t - 1000, 0],
                        [t, 0]
                    ],
                    color: '#009900'
                },
                {
                    name: 'Happy',
                    data: [
                        [t - 5000, 0],
                        [t - 4000, 0],
                        [t - 3000, 0],
                        [t - 2000, 0],
                        [t - 1000, 0],
                        [t, 0]
                    ],
                    color: '#FFFF00'
                },
                {
                    name: 'Bored',
                    data: [
                        [t - 5000, 0],
                        [t - 4000, 0],
                        [t - 3000, 0],
                        [t - 2000, 0],
                        [t - 1000, 0],
                        [t, 0]
                    ],
                    color: '#0066FF'
                },
                {
                    name: 'Sleepy',
                    data: [
                        [t - 5000, 0],
                        [t - 4000, 0],
                        [t - 3000, 0],
                        [t - 2000, 0],
                        [t - 1000, 0],
                        [t, 0]
                    ],
                    color: '#CC0000'
                }
            ]
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
                                y: Math.random()
                            });
                        }
                        return data;
                    })()
                }
            ]
        });
    });

});
    