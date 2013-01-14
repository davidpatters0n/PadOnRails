Highcharts.setOptions({
    colors: ['#2C4056', '#0098DB', '#2C4056', '#0098DB']
});


var chart;
$(document).ready(function() {
   chart = new Highcharts.Chart({
      chart: {
         renderTo: 'container',
         defaultSeriesType: 'column'
      },
      title: {
          text: 'DAI',
       
      },
      subtitle: {
         text: 'Project Hours'
      },
      xAxis: {
         categories: [
            'Support',
            'Project',
            'Fault-Fixing',
            'Out-Of-Hours',
            'Sick',
            'Toil',
            'Leave'  
         ]
      },
      yAxis: {
         min: 0,
         title: {
            text: 'Hours'
         }
      },
      legend: {
         layout: 'vertical',
         align: 'left',
         verticalAlign: 'top',
         x: 100,
         y: 70,
         floating: true,
         shadow: true
      },
      tooltip: {
         formatter: function() {
            return ''+
               this.x +': '+ this.y +' Hours';
         }
      },
        credits: {
        text: 'Dai.co.uk',
        href: 'http://www.Dai.co.uk'
    },
        exporting: {
        enabled: true,
        filename: 'Project-Hours'
    },
   
      plotOptions: {
         column: {
            pointPadding: 0.3,
            borderWidth: 0
         }
      },
           series: [{
         name: 'Honda',
         data: [15.0, 10.0, 25.0, 0.0, 0.0, 0.0, 0.0]
   
      }, {
         name: 'Asda',
         data: [10.0, 12.0, 10.0, 0.0, 8.0, 0.0, 0.0]
   
      }, {
         name: 'Screwfix',
         data: [5.0, 5.0, 24.0, 16.0, 0.0, 0.0, 0.0]
   
      }, {
         name: 'PadOnRails',
         data: [10.0, 20.0, 10.0, 0.0, 0.0, 0.0, 0.0]
   
      }]
   });
});