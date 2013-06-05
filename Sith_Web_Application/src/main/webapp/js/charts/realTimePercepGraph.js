/**
 * @author Sachintha
 */
$(function () {
		var source = new EventSource('http://localhost:3000/countPeriodicPerceptions');
		var t =  (new Date().getTime());
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
			  console.log(event.data);
			  var chart = $('#LiveChart').highcharts();
			  var xval = (new Date().getTime());
        		chart.series[0].addPoint([xval,data.data[0]],true, true);
        		chart.series[1].addPoint([xval,data.data[1]],true, true);
        		chart.series[2].addPoint([xval,data.data[2]],true, true);
        		chart.series[3].addPoint([xval,data.data[3]],true, true);
		}
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
                tickinterval:3000,
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
            series: [ {
                name: 'Interested',
                data: [[t-5000,0],[t-4000,0],[t-3000,0],[t-2000,0],[t-1000,0],[t,0]],
                color:'#009900'
            },{
                name: 'Happy',
                data: [[t-5000,0],[t-4000,0],[t-3000,0],[t-2000,0],[t-1000,0],[t,0]],
                color: '#FFFF00'
            },{
                name: 'Bored',
                data: [[t-5000,0],[t-4000,0],[t-3000,0],[t-2000,0],[t-1000,0],[t,0]],
                color: '#0066FF'
            },{
                name: 'Sleepy',
                data: [[t-5000,0],[t-4000,0],[t-3000,0],[t-2000,0],[t-1000,0],[t,0]],
                color: '#CC0000'
            }]
        });
    });
    