/**
 * @author Sachintha
 */
$(function () {
	$(document).ready(function(){
		var chart;
		$('#CountChart').highcharts({
            chart: {
                type: 'column',
                width: 900
            },
            title: {
                text: 'Perception Count'
            },
            
            xAxis: {
                categories: [
                    'Very Unhappy',
                    'Unhappy',
                    'Nutral',
                    'Happy',
                    'Very Happy',
                ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Count'
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
            legend:{
            	enabled: false
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                data: [10, 20, 30, 3, 2]
            }]
        });
    });
})
        