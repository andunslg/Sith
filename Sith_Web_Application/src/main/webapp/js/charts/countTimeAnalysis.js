/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 6/17/13
 * Time: 10:35 AM
 * To change this template use File | Settings | File Templates.
 */
$(function(){
        $.get('http://localhost:3000/getTimeAnalysis?eventID=test',function(data){
            var result = JSON.parse(data);
            for(var percep in result){
                if(percep == 'startTime'|| percep=='endTime'){
                  continue;
                }
                $("#perceptions").append($("<option />").val(percep).text(percep));
            };
            $("#perceptions").append($("<option />").val("stacked").text("Stacked Graph"));
            $("#perceptions").change(function (){
                var selected = $('#perceptions').val();
                if(selected == "stacked"){
                    stackedGraph();
                    return;
                }
                chart(selected,50000);
            });

            Highcharts.setOptions({
                global: {
                    useUTC: false
                }
            });
            chart = function(type,interval){
                var series = [{
                    name:type,
                    pointInterval: interval,
                    pointStart: result.startTime,
                    data: result[type],
                }]
                $('#TimeAnalysis').highcharts({
                chart: {
                    type: 'area',
                    zoomType: 'x',
                },
                title: {
                    text: 'Time Analysis Graph'
                },
                legend: {
                    layout: 'vertical',
                    align: 'left',
                    verticalAlign: 'top',
                    x: 150,
                    y: 100,
                    floating: true,
                    borderWidth: 1,
                    backgroundColor: '#FFFFFF'
                },
                xAxis: {
                    type: 'datetime',
                    //maxZoom:  24 * 3600000, // fourteen days
                    title: {
                        text: null
                    }
                },
                yAxis: {
                    title: {
                        text: 'Accumilated Perception Count',
                        min: 0,
                        startOnTick: false
                    }
                },
                tooltip: {
                    shared: true,
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    area: {
                        marker: {
                            enabled: false
                        },
                    }
                },
                series: series
            });
        };

        stackedGraph = function(){
                $('#TimeAnalysis').highcharts({
                    chart: {
                        type: 'area'
                    },
                    title: {
                        text: 'Historic and Estimated Worldwide Population Growth by Region'
                    },
                    subtitle: {
                        text: 'Source: Wikipedia.org'
                    },
                    xAxis: {
                        categories: ['1750', '1800', '1850', '1900', '1950', '1999', '2050'],
                        tickmarkPlacement: 'on',
                        title: {
                            enabled: false
                        }
                    },
                    yAxis: {
                        title: {
                            text: 'Billions'
                        },
                        labels: {
                            formatter: function() {
                                return this.value / 1000;
                            }
                        }
                    },
                    tooltip: {
                        shared: true,
                        valueSuffix: ' millions'
                    },
                    plotOptions: {
                        area: {
                            stacking: 'normal',
                            lineColor: '#666666',
                            lineWidth: 1,
                            marker: {
                                lineWidth: 1,
                                lineColor: '#666666'
                            }
                        }
                    },
                    series: [{
                        name: 'Asia',
                        data: [502, 635, 809, 947, 1402, 3634, 5268]
                    }, {
                        name: 'Africa',
                        data: [106, 107, 111, 133, 221, 767, 1766]
                    }, {
                        name: 'Europe',
                        data: [163, 203, 276, 408, 547, 729, 628]
                    }, {
                        name: 'America',
                        data: [18, 31, 54, 156, 339, 818, 1201]
                    }, {
                        name: 'Oceania',
                        data: [2, 2, 2, 6, 13, 30, 46]
                    }]
                });
        }

     });
});