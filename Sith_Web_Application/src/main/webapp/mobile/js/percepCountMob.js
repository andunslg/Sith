/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 6/28/13
 * Time: 4:52 PM
 * To change this template use File | Settings | File Templates.
 */
/**
 * @author Sachintha
 * This document contains barchart and pie chart to display perception counts
 */
barChart = function (perceptions, values) {
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
            exporting: {
                enabled:false
            },
            series: [
                {
                    data: values
                }
            ]
        });
}

pieChart = function (values) {
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
            exporting: {
                enabled:false
            },
            series: [
                {
                    type: 'pie',
                    name: 'Perception Count',
                    data: values
                }
            ]
        });
}