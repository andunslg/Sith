/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 6/28/13
 * Time: 8:28 PM
 * To change this template use File | Settings | File Templates.
 */
countTimeChartMob = function(url){
    $.get(url,function(data){
        var result;
        if(typeof data=='string' || data instanceof String){
            result = JSON.parse(data);
        }else{
            var result = data;
        }
        for(var percep in result){
            if(percep == 'startTime'|| percep=='endTime'|| percep=='interval'){
                continue;
            }
            $("#perceptions").append($("<option />").val(percep).text(percep));
        };
        $("#perceptions").append($("<option />").val("stacked").text("Stacked Graph"));
        $("#perceptions").val('stacked');
        $("#perceptions").change(function (){
            var selected = $('#perceptions').val();
            if(selected == "stacked"){
                stackedGraph();
                return;
            }
            chart(selected);
        });

        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
        chart = function(type){
            var series = [{
                name:type,
                pointInterval: result["interval"],
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
                exporting:{
                    enabled:false
                },
                series: series
            });
        };

        stackedGraph = function(){
            var series = new Array();
            for(var name in result){
                if(name == 'startTime'|| name=='endTime' || name == 'interval'){
                    continue;
                };
                var ob = new Object();
                ob.name = name;
                ob.data = result[name];
                ob.pointInterval = result.interval;
                ob.pointStart = result.startTime;
                series.push(ob);
            }
            $('#TimeAnalysis').highcharts({
                chart: {
                    type: 'area',
                    zoomType: 'x',
                },
                title: {
                    text: 'Perception Time Graph'
                },
                xAxis: {
                    type: 'datetime',
                    tickmarkPlacement: 'on',
                    title: {
                        enabled: false
                    }
                },
                yAxis: {
                    title: {
                        text: 'Count'
                    },
                    labels: {
                        formatter: function() {
                            return this.value;
                        }
                    }
                },
                tooltip: {
                    shared: true,
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
                exporting: {
                   enabled:false
                },
                series: series
            });

        }
        stackedGraph();
    });
};