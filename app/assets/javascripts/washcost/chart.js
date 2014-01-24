$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '.report--chart' ).each( function()
    {
      var container = $( this ),
          chart     = new WashCostLineChart().init(
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
    } );
  }


  init();
} );

