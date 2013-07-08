/**
 * @author Sachintha
 * This document contains barchart and pie chart to display perception counts
 */
barChart = function (perceptions, url,colors) {
    //load data from the server
    $.get(url, function (e) {
        var data = new Array();
        console.log(e);
        if(typeof e=='string' || e instanceof String){
            e = JSON.parse(e);
        }
        for(var i=0; i<perceptions.length;i++){
            perception = e.data[perceptions[i]];
            data[i] = new Object();
            if(perception){
                data[i].y =  perception;
                data[i].color = colors[i];
                console.log(data[i]);
            }else{
                data[i].y=0;
                data[i].color = colors[i]
                console.log(data[i]);
            }
        }
        var chart;
        $('#CountChart').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Perception Count'
            },

            xAxis: {
                categories: perceptions
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
            legend: {
                enabled: false
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [
                {
                    data: data
                }
            ]
        });
  });
}

pieChart = function (perceptions,url,colors) {
    $.get(url, function (e) {
        //var data = e.data;
        //var perceptions = JSON.stringify({Angry:data[0], Sad:data[1], Boring:data[2], Nutral:data[3], Happy:data[4], Excited:data[5]});
        Highcharts.setOptions({
            colors: colors
        });
        var data = new Array();
        console.log(e);
        if(typeof e=='string' || e instanceof String){
            e = JSON.parse(e);
        }
        for(var i=0; i<perceptions.length;i++){
            perception = e.data[perceptions[i]];
            if(perception){
                data[i] =  [perceptions[i], perception];
                console.log(data[i]);
            }else{
                data[i]=[perceptions[i], 0];
                console.log(data[i]);
            }
        }
        //Highcharts.setOptions({
        //    colors: colors;
       // });
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
                        formatter: function () {
                            return '<b>' + this.point.name + '</b>: ' + (this.percentage).toFixed(2) + ' %';
                        }
                    }
                }
            },
            series: [
                {
                    type: 'pie',
                    name: 'Perception Count',
                    data: data
                }
            ]
        });
    })
}       