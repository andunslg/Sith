/**
 * @author Sachintha
 */
$(function () {
		var source = new EventSource('http://localhost:3000/countPeriodicPerceptions');
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
        		chart.series[0].addPoint(data.data[0],true, true);
        		chart.series[1].addPoint(data.data[1],true, true);
        		chart.series[2].addPoint(data.data[2],true, true);
        		chart.series[3].addPoint(data.data[3],true, true);
			}
        $('#LiveChart').highcharts({
            chart: {
                type: 'area',
                animation: Highcharts.svg,
            },
            title: {
                text: 'Live Perception of Your Audience!'
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
                    text: 'Percent'
                }
            },
            tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.percentage:.1f}%</b> ({point.y:,.0f} millions)<br/>',
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
                data: [102, 345, 32, 556, 978, 342, 553],
                color:'#009900'
            },{
                name: 'Happy',
                data: [18, 31, 54, 156, 339, 818, 1201],
                color: '#FFFF00'
            },{
                name: 'Bored',
                data: [18, 31, 54, 156, 339, 818, 1201],
                color: '#0066FF'
            },{
                name: 'Sleepy',
                data: [163, 203, 276, 408, 547, 729, 628],
                color: '#CC0000'
            }]
        });
    });
    