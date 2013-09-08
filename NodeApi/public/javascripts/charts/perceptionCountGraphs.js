/**
 * @author Sachintha
 * This document contains barchart and pie chart to display perception counts
 */
$(document).ready(function(){
	barChart();
	$("#chartType").change(function(){
		if($('#chartType').val()== 'bar'){
		barChart();
	}else{
		pieChart();
	}
  });
})
	

barChart = function () {
	//load data from the server
	$.get('http://192.248.8.246:3000/countPerceptions', function (e) {
		var chart;
		var perceptions;
		$.ajax({
				type: "GET",
				url: "http://192.248.8.246:3000/countPerceptions",
				success: function(e){
					this.perceptions = e;
					console.log(this.perceptions);
				}
			});
			//console.log()
		$('#CountChart').highcharts({
            chart: {
                type: 'column',
            },
            title: {
                text: 'Perception Count'
            },
            
            xAxis: {
                categories: [
                    'Angry',
                    'Sad',
                    'Boring',
                    'Nutral',
                    'Happy',
                    'Excited'
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
                pointFormat: '<tr><td style="color:{series.color};padding:0">Perception</td>' +
                    '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
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
            data: e.data
            }]
        });
    });
}
 
pieChart = function () {
	$.get('http://192.248.8.246:3000/countPerceptions', function (e){
		//var data = e.data;
		//var perceptions = JSON.stringify({Angry:data[0], Sad:data[1], Boring:data[2], Nutral:data[3], Happy:data[4], Excited:data[5]});
		
        $('#CountChart').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'Perception Count'
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            	percentageDecimals: 1
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name +'</b>: '+ (this.percentage).toFixed(2) +' %';
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: 'Perception Count',
                data: [
                ['Angry', e.data[0]],
                ['Sad',e.data[1] ],
                ['Boring',e.data[2]],
                ['Nutral',e.data[3]],
                {
                	name: 'Happy',
                    y: e.data[4],
                    sliced: true,
                    selected: true
                },
                ['Excited',e.data[5]]
                ]
            }]
        });
     })
}       