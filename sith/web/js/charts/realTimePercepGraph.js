/**
 * @author Sachintha
 */
$(function () {
    $(document).ready(function() {
    	var messages = [];
    	var xVal;
   		var yVal=0;
    	var source = new EventSource('/stats');
		source.onopen = function () {
 			console.log('open')
		};	

		source.onerror = function () {
  			console.log('error');
		};

		//Event listners for page stats
		source.addEventListener('graph', updateChart, false);
    	
   		function updateChart(event){
			  var data = JSON.parse(event.data);
			  console.log("ID: "+data.id);
			  console.log("date: "+data.timeStamp);
			  console.log("value: "+data.value);
			 // xVal = data.timeStamp;
			  yVal = parseFloat(data.value);
			}
    	
    	//chart drawing
        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
        var chart;
        $('#LiveChart').highcharts({
            chart: {
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
                events: {
                    load: function() {
    
                        // set up the updating of the chart each second
                        var series = this.series[0];
                        setInterval(function() {
                            var x = (new Date().getTime()) , // current time
                                y = yVal;
                            series.addPoint([x, y], true, true);
                        }, 5000);
                    }
                }
            },
            title: {
                text: 'Live Perception'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'Average Perception'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: true
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;
    
                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: Math.random()
                        });
                    }
                    return data;
                })()
            }]
        });
    });
    
})