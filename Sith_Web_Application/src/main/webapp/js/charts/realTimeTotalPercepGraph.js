/**
 * @author Sachintha
 */
$(function () {
    $(document).ready(function() {
    	var messages = [];
    	var xVal;
   		var yVal=0;
    	var source = new EventSource('http://localhost:3000/countTotalPerceptions');
		source.onopen = function () {
 			console.log('open')
		};	

		source.onerror = function () {
  			console.log('error');
		};

		//Event listners for page stats
		source.addEventListener('Totgraph', updateChart2, false);
    	
   		function updateChart2(event){
			  var data2 = JSON.parse(event.data);
			  console.log(event.data);
			  var chart2 = $('#TotLiveChart').highcharts();
			  var xval2 = (new Date().getTime());
        	  chart2.series[0].addPoint([xval2,data2.length],true, true);					  
			}
    	
    	//chart drawing
        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
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
                tickinterval:3000,
            },
            yAxis: {
                title: {
                    text: 'Total Perception'
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
    
                    for (i = -6; i <= 0; i++) {
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