$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '.report--chart' ).each( function()
    {
      var container = $( this ),
          type      = container.data( 'chart-type' ),
          chart;

      if ( type == 'advanced' )
      {
        chart = new WashCostAreaChart().init(
        {
          parent: $( this )[0],
          id: 'washcostSustainChart',
          dimensions: { width:container.width(), height:container.height() },
          padding:{ top:40, right:40, bottom:40, left:90 },
          axisTypes:{ x:'linear', y:'linear', z:null },
          tickFormatters:{ y:function( d ) { return "USD$ " + d; } },
          yAxisTitle:'Recurrent Costs',
          lineStrokeDash:[ 5, 5 ],
          hideAxes:false,
          xAxisStyle:{ hide:false, tickTextSize:'12px', textWeight:300, textColour:'#797979', titleColour:'#a6955e', tickColour:'', tickSize:6, tickPadding:8, tickCount:30, textFamily:'Helvetica', lineColour:'transparent', renderSymbol:false, renderGridLines:true },
          yAxisStyle:{ hide:false, tickTextSize:'12px', textColour:'#797979', titleColour:'#797979', tickColour:'', tickSize:0, tickCount:4, textFamily:'Helvetica', lineColour:'transparent', renderSymbol:false, renderGridLines:false },
          gridLineStyle:{ colour: '#999999', dashArray:[ ] },
          shouldScrub:false,
          yPadding:0.3,
          dataAccessors:{ x:function( d ){ return d.year; }, y:function( d ){ return d.cost; } }
        } );

        chart.render(
        [
          {
            seriesName:'Minor operation and maintenance expenditure',
            colour:'#6775f2',
            data:
            [
{ year:1, cost:40 }, { year:1, cost:40 }, { year:1, cost:40 }, { year:1, cost:40 }
            ]
          },
          {
            seriesName:'Expenditure on direct support',
            colour:'#6775f2',
            data:
            [
{ year:1, cost:40 }, { year:1, cost:40 }, { year:1, cost:40 }, { year:1, cost:40 }
            ]
          },
          {
            seriesName:'Capital maintenance expenditure',
            colour:'#6775f2',
            data:
            [
{ year:1, cost:40 }, { year:1, cost:40 }, { year:1, cost:40 }, { year:1, cost:40 }
            ]
          },
          {
            seriesName:'Total',
            colour:'#6775f2',
            data:
            [
{ year:1, cost:40 }, { year:1, cost:40 }, { year:1, cost:40 }, { year:1, cost:40 }
            ]
          }
        ] );
      }
      else
      {
        chart = new WashCostLineChart().init(
        {
          parent: $( this )[0],
          id: 'washcostlineChart',
          dimensions: { width:container.width(), height:container.height() },
          padding:{ top:40, right:40, bottom:40, left:40 },
          axisTypes: {x:'linear', y:'linear', z:null},
          colourPalette:[ '#ffffff' ],
          backgroundColour: 'transparent',
          lineStrokeColour: 'white',
          hideAxes:false,
          xAxisStyle: { hide:false, tickTextSize:'10px', titleTextSize:'13px', textWeight:300, textColour:'#a6955e', titleColour:'#a6955e', tickColour:'', tickSize:6, tickPadding:8, tickCount:10, textFamily:'Helvetica', lineColour:'transparent', renderSymbol:false },
          yAxisStyle: { hide:true },
          gridLineStyle:{ colour: '#a6955e', dashArray:[ ] },
          shouldScrub:false,
          yPadding:0.3,
          dataAccessors:{ x:function(d){ return d.x; }, y:function(d){ return d.y; } }
        } );

        chart.render(
        {
          capital: container.data( 'chart-capital' ),
          recurrent: container.data( 'chart-recurrent' ),
          population: container.data( 'chart-population' )
        } );
      }
    } );
  }


  init();
} );

