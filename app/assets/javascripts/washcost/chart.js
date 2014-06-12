$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '.report--chart' ).each( function()
    {
      var container    = $( this ),
          type         = container.data( 'chart-type' ),
          datapoints   = [],
          seed_points = container.data( 'chart-seeds' ),
          currency    = container.data( 'chart-currency' ),
          tech    = container.data( 'chart-tech' ),
          loan_cost    = container.data( 'chart-loancost' ),
          loan_payback    = container.data( 'chart-loanpayback' ),
          chart, i, j;

                    /*multipliers  =
          [
            [ 1,1,1,1,1.5,1,1,1,1,1.5,1,1,3,1,1,1.5,1,1,1,1,2.25,1,1,1,2.5,1,1,1,2.5,4 ],
            [ 1,1,1,1,1.5,1,1,1,1,1.5,1,1,4.5,1,1,2,1,1,1,1,3,1,1,1,4,1,1,1,3.5,6 ],
          ],*/

      if ( type == 'advanced' )
      {
        chart = new WashCostAreaChart().init(
        {
          parent: $( this )[0],
          id: 'washcostSustainChart',
          dimensions: { width:container.width(), height:container.height() },
          padding:{ top:10, right:40, bottom:60, left:90 },
          axisTypes:{ x:'linear', y:'linear', z:null },
          tickFormatters:{ y:function( d ) { return currency + ' ' + d; } },
          yAxisTitle:'Recurrent Costs',
          xAxisTitle:'Year',
          lineStrokeDash:[ 5, 5 ],
          hideAxes:false,
          lockAxesToZero:false,
          xAxisStyle:{ hide:false, tickTextSize:'12px', textWeight:300, textColour:'#797979', titleColour:'#333333', tickColour:'', tickSize:6, tickPadding:8, tickCount:30, textFamily:'Helvetica', lineColour:'transparent', renderSymbol:false, renderGridLines:true },
          yAxisStyle:{ hide:false, tickTextSize:'12px', textColour:'#797979', titleColour:'#333333', tickColour:'', tickSize:0, tickCount:4, textFamily:'Helvetica', lineColour:'transparent', renderSymbol:false, renderGridLines:false },
          gridLineStyle:{ colour: 'rgba(0,0,0,0.1)', dashArray:[ ] },
          shouldScrub:false,
          yPadding:0.3,
          primaryAnimationDuration:1,
          secondaryAnimationDuration:700,
          dataAccessors:{ x:function( d ){ return d.year; }, y:function( d ){ return d.cost; } }
        } );

        var chartObjects = [];

        var operation_expenditure_per_year = [];

        for ( i = 0; i < 30; i++ )
          operation_expenditure_per_year[i] = { year:i + 1, cost:seed_points[0] };

        chartObjects.push({ seriesName: 'operation_expenditure_per_year', colour: '#858687', data: operation_expenditure_per_year });

        var direct_support_per_year = [];

        for ( i = 0; i < 30; i++ )
          direct_support_per_year[i] = { year:i + 1, cost:seed_points[1] };

        chartObjects.push({ seriesName: 'direct_support_per_year', colour: '#f8ea03', data: direct_support_per_year });

        var indirect_support_per_year = [];

        for ( i = 0; i < 30; i++ )
          indirect_support_per_year[i] = { year:i + 1, cost:seed_points[2] };

        chartObjects.push({ seriesName: 'indirect_support_per_year', colour: '#1f9ed8', data: indirect_support_per_year });

        var cost_capital_tech = [];

        for ( i = 0; i < 4; i++ ) {
          cost_capital_tech[i] = [];
          for ( j = 0; j < 31; j++ ) {
            cost_capital_tech[i][j] = { year:j + 1, cost: (loan_payback[i] <= (j+1)) ? loan_cost[i] : 0 };
          }
          chartObjects.push({ seriesName: 'cost_of_capital_' + i, colour: '#ff6600', data: cost_capital_tech[i] });
        }

        console.log(chartObjects);

        // build data based on multipliers
        /*for ( i = 0; i < 2; i++ )
        {
          datapoints[i] = [];

          for ( j = 0; j < 30; j++ )
          {
            datapoints[i][j] = { year:j + 1, cost:seed_points[i] };
          }
        }
        for ( i = 2; i < 4; i++ )
        {
          datapoints[i] = [];

          for ( j = 0; j < 30; j++ )
          {
            datapoints[i][j] = { year:j + 1, cost:seed_points[i] * multipliers[i-2][j] };
          }
        }*/

        chart.render( chartObjects
        /*[
          {
            seriesName: 'operation_expenditure_per_year',
            colour: '#858687',
            data: operation_expenditure_per_year
          },
          {
            seriesName: 'direct_support_per_year',
            colour: '#f8ea03',
            data: direct_support_per_year
          },
          {
            seriesName: 'indirect_support_per_year',
            colour: '#1f9ed8',
            data: indirect_support_per_year
          },
          {
            seriesName: 'cost_of_capital_0',
            colour: '#1f9ed8',
            data: cost_capital_tech[0]
          },
          {
            seriesName: 'cost_of_capital_1',
            colour: '#1f9ed8',
            data: cost_capital_tech[1]
          },
          {
            seriesName: 'cost_of_capital_2',
            colour: '#1f9ed8',
            data: cost_capital_tech[2]
          },
          {
            seriesName: 'cost_of_capital_3',
            colour: '#1f9ed8',
            data: cost_capital_tech[3]
          }*/
          /*{
            seriesName:'Total',
            colour:'#858687',
            data:datapoints[3]
          },
          {
            seriesName:'Capital maintenance expenditure',
            colour:'#f8ea03',
            data:datapoints[2]
          },
          {
            seriesName:'Expenditure on direct support',
            colour:'#1f9ed8',
            data:datapoints[1]
          },
          {
            seriesName:'Minor operation and maintenance expenditure',
            colour:'#e52184',
            data:datapoints[0]
          }
        ]*/ );
      }
      else
      {
        chart = new WashCostLineChart().init(
        {
          parent: $( this )[0],
          id: 'washcostlineChart',
          dimensions: { width:container.width(), height:container.height() },
          padding:{ top:40, right:0, bottom:40, left:52 },
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

