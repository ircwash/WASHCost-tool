/*jshint browser:true, undef:true, latedef:true, forin:true, eqeqeq:true, noarg:true, onevar:true, globalstrict:true, lastsemic:true, smarttabs:true, trailing:true, newcap:false */
/*global define:true, require:true, d3:true */

window.WashCostAreaChart = (function()
{
	'use strict';

	// define helper
	var Helper = {};

	Helper.extend = function( a, b )
	{
		for( var key in b )
		{
			if( b.hasOwnProperty( key ) ) a[ key ] = b[ key ];
		}
		return a;
	};

	// define chart
	var WashCostAreaChart = function ( options ) { };

	WashCostAreaChart.prototype = {

		init: function( options )
		{
			var self = this,
				brushXScale,
				brushYScale;

			// Copy options from constructor
			this.parent                     = options.parent || null;
			this.id                         = options.id || new Date().getTime();
			this.renderUsingCanvas          = options.renderUsingCanvas === true ? true : false;
			this.backgroundColour           = options.backgroundColour || 'transparent';
			this.dimensions                 = options.dimensions || { width:100, height:100 };
			this.autoResize                 = options.autoResize === true ? true : false;
			this.padding                    = Helper.extend( { top:0, right:0, bottom:0, left:0 }, options.padding );
			this.axisTypes                  = Helper.extend( { x:null, y:null, z:null }, options.axisTypes );
			this.dataAccessors              = Helper.extend( { x:null, y:null, z:null }, options.dataAccessors );
			this.dataPosAccessors           = options.dataPosAccessors || { x:function( d ) { return self.xScale( self.dataAccessors.x( d ) ); }, y:function( d ) { return self.yScale( self.dataAccessors.y( d ) ); }, z:function( d ) { return self.zScale( self.dataAccessors.z( d ) ); }  };
			this.seriesNameAccessor         = options.seriesNameAccessor || function( d ) { return d.seriesName };
			this.hideAxes                   = options.hideAxes || false;
			this.hideGridLines              = options.hideGridLines || false;
			this.hideZeroLines              = options.hideZeroLines === false ? false : true;
			this.gridLineStyle              = Helper.extend( { colour: '#dfdfdf', dashArray:[ ] }, options.gridLineStyle );
			this.renderToolTips             = options.renderToolTips || false;
			this.toolTipStyle               = Helper.extend( { detectionRadius:25, width:'80px', padding:'15px', pointerSize:10, backgroundColour:'white', borderColour:'#a5a5a5', borderWidth:1, borderRadius:'3px', shadowRadius:5, shadowColor:'#000', textFamily:'Helvetic Neue, Helvetica, Arial', textColour:'black', textTransform:'uppercase', textAlign:'center' }, options.toolTipStyle );
			this.shouldScrub                = options.shouldScrub || false;
			this.shouldZoom                 = options.shouldZoom || false;
			this.interpolation              = options.interpolation || "linear";	// how we smooth (or don't smooth) lines on line and area charts
			this.percentFormat              = options.percentFormat || ".0%";
			this.numberFormat               = options.numberFormat || "s";
			this.dateFormat                 = options.dateFormat || "%Y-%m-%d";
			this.colourPalette              = options.colourPalette instanceof Array ? d3.scale.ordinal().range( options.colourPalette ) : d3.scale.ordinal().range( [ "#E8CEBA", "#9C94DB", "#9FDFD8", "#D0718B" ] );
			this.primaryAnimationDuration   = options.primaryAnimationDuration || 1000;
			this.secondaryAnimationDuration = options.secondaryAnimationDuration || 150;
			this.xPadding                   = options.xPadding  || 0.0;
			this.yPadding                   = options.yPadding  || 0.0;
			this.zPadding                   = options.zPadding  || 0.0;
			this.shouldLockAxesToPositive   = options.shouldLockAxesToPositive === false ? false : true;
			this.timePaddingSecs            = options.timePaddingSecs || 0;
			this.textColour                 = options.textColour || 'black';
			this.textSize                   = options.textSize || '14px';
			this.textWeight                 = options.textWeight || 600;
			this.textFamily                 = options.textFamily || 'Helvetica, Arial';
			this.xAxisStyle                 = Helper.extend( { hide:false, tickTextSize:'10px', titleTextSize:'13px', textWeight:300, textColour:'white', titleColour:'white', tickColour:'white', tickSize:6, tickPadding:8, textFamily:'Helvetica', lineColour:'black', renderSymbol:false, renderGridLines:false }, options.xAxisStyle );
			this.yAxisStyle                 = Helper.extend( { hide:false, tickTextSize:'10px', titleTextSize:'13px', textWeight:300, textColour:'white', titleColour:'white', tickColour:'white', tickSize:6, tickPadding:8, textFamily:'Helvetica', lineColour:'black', renderSymbol:false, renderGridLines:false }, options.yAxisStyle );
			this.zAxisStyle                 = Helper.extend( { hide:false, tickTextSize:'10px', titleTextSize:'13px', textWeight:300, textColour:'white', titleColour:'white', tickColour:'white', tickSize:6, tickPadding:8, textFamily:'Helvetica', lineColour:'black', renderSymbol:false, renderGridLines:false }, options.zAxisStyle );
			this.xAxisTitle                 = options.xAxisTitle || '';
			this.yAxisTitle                 = options.yAxisTitle || '';
			this.zAxisTitle                 = options.zAxisTitle || '';
			this.xAxisUnit                  = options.xAxisUnit || '';
			this.yAxisUnit                  = options.yAxisUnit || '';
			this.zAxisUnit                  = options.zAxisUnit || '';
			this.tickFormatters             = Helper.extend( { x:null, y:null, z:null }, options.tickFormatters );
			this.timeAxisTickInterval       = this.timeIntervalForIntervalName( options.timeAxisTickInterval || 'months' );
			this.hasBrush                   = options.hasBrush || false;
			this.brushOptions               = Helper.extend(  { parent:null, dimensions:{ width:100, height:25 }, backgroundColour:'transparent', focusBackgroundColour:'transparent', shadeOpacity:0.0, handles:{ width:20, image:null } }, options.brushOptions );
			this.lineStrokeWidth            = options.lineStrokeWidth || 2.0;
			this.lineStrokeDash             = options.lineStrokeDash || [];
			this.selectedDataPointStyle     = options.selectedDataPointStyle || { strokeWidth:1.0, strokeColour:'#888', fillColour:'#FFF', radius:20 };
			this.dataPointStyle             = options.dataPointStyle || { strokeWidth:2.0, strokeColour:'#888', fillColour:'#F00', radius:0 };


			// create formatters from strings
			this.percentFormatter = d3.format( this.percentFormat );
			this.dateFormatter = d3.time.format( this.dateFormat );

			//

			// parse ints in case someone passed us strings...
			if ( options.padding )
			{
				this.padding.top = +options.padding.top || 0;
				this.padding.right = +options.padding.right || 0;
				this.padding.bottom = +options.padding.bottom || 0;
				this.padding.left = +options.padding.left || 0;
			}

			// calculate size of our charting area...
			this.width  = this.dimensions.width - this.padding.left - this.padding.right;
			this.height = this.dimensions.height - this.padding.top - this.padding.bottom;

			// incase someone forgot to set dimensions, set a default
			if ( this.width < 0 ) this.width = 100;

			if ( this.height < 0 ) this.height = 100;

			// check for the dreaded IE...
			this.ie8Detected = ( navigator.userAgent.match( /MSIE/ ) ) ? true : false;

			// set up scales and axis...
			if ( this.axisTypes.x )
			{
				this.xScale = this.scaleForType( this.axisTypes.x );
				this.xAxis = d3.svg.axis()
					.scale( this.xScale )
					.orient( "bottom" )
					.tickPadding( this.xAxisStyle.tickPadding )
					.tickSize( this.xAxisStyle.tickSize, this.xAxisStyle.tickSize / 2, this.xAxisStyle.tickSize )
					.ticks( this.xAxisStyle.tickCount );

				if ( this.axisTypes.x === 'time' ) { this.xAxis.ticks( this.timeAxisTickInterval ); }
				if ( !this.dataAccessors.x ) { this.dataAccessors.x = this.defaultAccessorForAxisType( this.axisTypes.x ); }
			}
			if ( this.axisTypes.y )
			{
				this.yScale = this.scaleForType( this.axisTypes.y );
				this.yAxis = d3.svg.axis()
					.scale( this.yScale )
					.orient( "left" )
					.ticks( Math.round( this.height / 80 ) )
					.tickPadding( this.yAxisStyle.tickPadding )
					.tickSize( this.yAxisStyle.tickSize, this.yAxisStyle.tickSize / 2, this.yAxisStyle.tickSize )
					.ticks( this.yAxisStyle.tickCount );

				if ( this.axisTypes.y === 'time' ) { this.yAxis.ticks( this.timeAxisTickInterval ); }
				if ( !this.dataAccessors.y ) { this.dataAccessors.y = this.defaultAccessorForAxisType( this.axisTypes.y ); }
			}
			if ( this.axisTypes.z )
			{
				this.zScale = this.scaleForType( this.axisTypes.z );
				this.zAxis = d3.svg.axis()
					.scale( this.zScale )
					.orient( "right" )
					.ticks( Math.round( this.height / 80 ) )
					.tickPadding( this.zAxisStyle.tickPadding )
					.tickSize( this.zAxisStyle.tickSize, this.zAxisStyle.tickSize / 2, this.zAxisStyle.tickSize )
					.ticks( this.zAxisStyle.tickCount );

					if ( this.axisTypes.z === 'time' ) { this.zAxis.ticks( this.timeAxisTickInterval ); }
					if ( !this.dataAccessors.z ) { this.dataAccessors.z = this.defaultAccessorForAxisType( this.axisTypes.z ); }
			}

			if ( this.hasBrush )
			{
				// set up our brush
				brushXScale = this.scaleForType( this.axisTypes.x ).domain( this.xScale.domain() ).range( [ 0, this.brushOptions.dimensions.width ] );
				brushYScale = this.scaleForType( this.axisTypes.y ).domain( this.yScale.domain() ).range( [ this.brushOptions.dimensions.height, 0 ] );

				this.brush = {
					xScale:brushXScale,
					yScale:brushYScale,
					constructor:d3.svg.brush().x( brushXScale ).on( 'brush', function() { self.brushed.apply( self, arguments ) } )
				};
				this.brush.canvas = d3.select( this.brushOptions.parent )
					.style( 'background-color', this.brushOptions.backgroundColour )
					.append( "svg" )
						.attr( "width", this.brushOptions.dimensions.width )
						.attr( "height", this.brushOptions.dimensions.height )
						.attr( "id", this.id + '-brush' )
						.append( "g" );
			}

			// set up this.canvas, our root node

			this.canvas = d3.select( this.parent ).append( "svg" )
			.attr( "width", this.width + this.padding.left + this.padding.right )
			.attr( "height", this.height + this.padding.top + this.padding.bottom )
			.attr( "id", this.id )
			.append( "g" )
				.attr( "transform", "translate(" + this.padding.left + "," + this.padding.top + ")" );

			// set up zooming
			if ( this.shouldZoom )
			{
				// set up zoom functionality
				this.zoom = d3.behavior.zoom()
					.on( 'zoom', function() { self.redraw.apply( self, arguments ) } )
					.scaleExtent( [ 1, 20 ] );

				d3.select( this.parent ).call( this.zoom );
			}

			if ( this.backgroundColour !== 'transparent' )
			{
				// add rect for background fill
				this.chartBackground = this.canvas.append( 'rect' )
					.attr( 'width', this.width + this.padding.left + this.padding.right )
					.attr( 'height', this.height + this.padding.top + this.padding.bottom )
					.attr( 'x', - this.padding.left )
					.attr( 'y', - this.padding.top )
					.attr( 'class', 'chartBackground' )
					.style( 'fill', this.backgroundColour );
			}

			// append clipping path
			this.clipPath = this.canvas.append( "clipPath" )
				.attr( "id", this.id + "-chart-area" )
				.append( "rect" )
					.attr( "x", 0 )
					.attr( "y", 0 )
					.attr( "width", this.width )
					.attr( "height", this.height )
					.attr( 'opacity', 0 );

			// create tooltip
			if ( this.renderToolTips ) this.renderToolTip();


			// set up for scrub type tooltips
			if ( this.shouldScrub )
			{
				// attach event handler to the main canvas
				d3.select( this.parent ).on( 'touchmove', function()
					{
						var touches = d3.touches( this );
						d3.event.preventDefault();
						d3.event.stopPropagation();
						self.scrubbed.call( self, touches[0] );  // call function with first touch only
					} );

				d3.select( this.parent ).on( 'mousemove', function()
					{
						var mousePos = d3.mouse( this );
						self.scrubbed.call( self, self.parentPosToChartPos( mousePos ) );
					} );
			}

			// set up auto resize
			if ( this.autoResize && !this.ie8Detected )
			{
				d3.select( window ).on( 'resize.' + this.id, function( e )
				{
					self.resizeToFitParent.apply( self );
				} );
			}

			return this;
		},


		render: function( data )
		{
			this.data                       = data[0] instanceof Array ? data : [ data ];  // cache data
			console.log( this.data );

			var self                        = this,
			    xScale                      = this.xScale,
			    xScale2                     = this.xScale2,
			    yScale                      = this.yScale,
			    yScale2                     = this.yScale2,
			    zScale                      = this.zScale,
			    height                      = this.height,
			    width                       = this.width,
			    xAxis                       = this.xAxis,
			    yAxis                       = this.yAxis,
			    zAxis                       = this.zAxis,
			    colourPalette               = this.colourPalette,
			    colourPalette1              = this.colourPalette1,
			    dataAccessors               = this.dataAccessors,
			    gridLineStyle               = this.gridLineStyle,
			    primaryAnimationDuration    = this.primaryAnimationDuration,
			    secondaryAnimationDuration  = this.secondaryAnimationDuration,
			    dataPointStyle              = this.dataPointStyle,
			    seriesLength,
			    lineConstructor,
			    brushLineConstructor,
			    middleLineConstructor,
			    zeroLineConstructor,
			    lines0,
			    lines1,
			    points0,
			    points1,
			    series0,
			    series1,
			    brushSeries,
			    brushLines,
			    tooltip,
			    selectedDataPointStyle,
			    nestedData,
			    areaConstructor,
			    areaFills0,
			    areaFills1,
			    i;


			//keep tab of max number of data points for animations...
			seriesLength = d3.max( this.data, function( d ) { return d3.max( d, function( s ) { return s.data.length; } ); } );

			//set up scales
			xScale.domain(
			[
				d3.min( this.data, function( d ) { return d3.min( d, function( s ) { return d3.min( s.data, dataAccessors.x ); } ) } ),
				d3.max( this.data, function( d ) { return d3.max( d, function( s ) { return d3.max( s.data, dataAccessors.x ); } ) } )
			] )
			.rangeRound( [ 0, width ] )
			.nice();

			yScale.domain( [ d3.min( this.data[ 0 ], function( s ) { return d3.min( s.data, dataAccessors.y ); } ),
					         d3.max( this.data[ 0 ], function( s ) { return d3.max( s.data, dataAccessors.y ); } ) ] )
				.rangeRound( [ height, 0] )
				.nice();

			// index all the datapoints for later reference during scrubbing
			this.dataByXValue = {};
			this.indexDataByXValue( this.data[ 0 ], dataAccessors.x, this.dataByXValue );

			// pad domains
			this.applyAxisPadding();

			//set up axis if we're drawing them
			if ( !this.hideAxes )
			{
				// Draw X-axis grid lines
				if ( !this.hideGridLines && this.xAxisStyle.renderGridLines ) this.renderGridLines( 'x' );

				// Draw Y-axis grid lines
				if ( !this.hideGridLines && this.yAxisStyle.renderGridLines ) this.renderGridLines( 'y' );

				// draw a zero-line along the x plane
				if ( !this.hideZeroLines ) this.renderZeroLine( 'y' );

				// render axis last so that they are one top
				this.renderAxis( 'y' );
				if ( this.isTripleAxis ) this.renderAxis( 'z' );
			}

			// set up brush scaling
			if ( this.hasBrush )
			{
				this.brush.xScale.domain( xScale.domain() );
				this.brush.yScale.domain( yScale.domain() );
			}

			//build clipping rectangle for line entrance animation
			this.lineClipPath = this.canvas.append( "clipPath" )
				.attr( "id", this.id + '-line-clip-path' )
				.append( "rect" )
					.attr( "x", 0 )
					.attr( "y", 0 )
					.attr( "width", 0 )
					.attr( "height", this.height )
					.attr( 'opacity', 0 )
					.transition()
					.duration( this.secondaryAnimationDuration )
					.delay( primaryAnimationDuration + secondaryAnimationDuration )
					.attr('width', this.width )
					.each( 'end', function()  // on animation end, set clip path to the chart area bounds
					{
						d3.selectAll( 'g.series0' ).attr( "clip-path", 'url(#' + this.id + '-point-clip-path)' );
						d3.selectAll( 'g.series1' ).attr( "clip-path", 'url(#' + this.id + '-point-clip-path)' );

						d3.selectAll( 'g.series0 path' ).attr( "clip-path", 'url(#' + this.id + '-chart-area)' );
						d3.selectAll( 'g.series1 path' ).attr( "clip-path", 'url(#' + this.id + '-chart-area)' );

						// remove clip path at the end of the animation
						d3.select( '#' + this.id + 'line-clip-path').remove();
					} );

			// build another clip path for the points
			// append clipping path
			this.pointClipPath = this.canvas.append( "clipPath" )
				.attr( "id", this.id + '-point-clip-path' )
				.append( "rect" )
					.attr( "x", 0 - this.dataPointStyle.radius - this.dataPointStyle.strokeWidth )
					.attr( "y", 0 - this.dataPointStyle.radius - this.dataPointStyle.strokeWidth )
					.attr( "width", this.width +  ( 2 * ( this.dataPointStyle.radius + this.dataPointStyle.strokeWidth ) ) )
					.attr( "height", this.height +  ( 2 * ( this.dataPointStyle.radius + this.dataPointStyle.strokeWidth ) ) )
					.attr( 'opacity', 0 );

			// build the line elements

			// define line constructor function
			lineConstructor = d3.svg.line()
				.x( function( d ) { return xScale( self.dataAccessors.x( d ) ); } )
				.y( function( d ) { return yScale( self.dataAccessors.y( d ) ); } )
				.interpolate( this.interpolation );

			this.lineConstructor = lineConstructor;

			zeroLineConstructor = d3.svg.line()
				.x( function( d ) { return xScale( self.dataAccessors.x( d ) ); } )
				.y( function( d ) { return yScale( 0 ); } )
				.interpolate( this.interpolation );

			middleLineConstructor = d3.svg.line()
				.x( function( d ) { return xScale( self.dataAccessors.x( d ) ); } )
				.y( function( d ) { return yScale( 0 ); } )
				.interpolate( this.interpolation );

			areaConstructor = d3.svg.area()
					.interpolate( this.interpolation )
					.x( function( d ) { return xScale( self.dataAccessors.x( d ) ); } )
					.y0( height )
					.y1( function( d ) { return yScale( self.dataAccessors.y( d ) ); } );

			this.areaConstructor = areaConstructor;

			/*
				start by constructing the regular y axis series,
				if we have a z/y2 axis, we'll swap the constructor y accessors round and render those
			*/

			// construct a group which will contain the paths, fills etc for all y1-axis elements
			series0 = this.canvas.append( "g" )
					.attr( "class", "series0" );
			this.series0 = series0;


			// construct the area fill which will go under the lines
			areaFills0 = series0.selectAll( 'path.dataFill' )
			.data( this.data[ 0 ] )
			.enter().append( 'path' )
				.attr( "class", "dataFill" )
				.attr( "clip-path", "url(#line-clip-path)" )
				.attr( "d", function( d ) { return areaConstructor( d.data ); } )
				.attr( 'pointer-events', 'none' )
				.style( 'stroke', function( d, i ) { var colour = d.colour || colourPalette( i ); return colour; } )
				.style( 'fill', function( d, i ) { var colour = d.colour || colourPalette( i ); return colour; } )
				.style( 'opacity', 0.3 );


			// construct the lines
			lines0 = series0.selectAll( 'path.dataLine' )
			.data( this.data[ 0 ], this.seriesNameAccessor )
			.enter().append( 'path' )
				.attr( "class", "dataLine" )
				.attr( "clip-path", this.ie8Detected ? 'none' : 'url(#' + this.id + '-line-clip-path)' )
				.attr( "d", function( d ) { return lineConstructor( d.data ); } )
				.style( 'stroke-width', this.lineStrokeWidth )
				.style( 'stroke', function( d, i ) { var colour = d.colour || colourPalette( i ); return colour; } )
				.style( 'stroke-dasharray', self.lineStrokeDash )
				.style( 'fill', 'none' );

			// build the point groups
			points0 = series0.selectAll( "g.pointGroup" )
			.data( this.data[ 0 ], this.seriesNameAccessor )
			.enter().append( 'g' )
				.attr( "class", "pointGroup" )
				.style( 'stroke', function( d, i ) { var colour = d.colour || colourPalette( i ); return colour; } );

			// build the points for each point group
			points0.selectAll( 'circle.dataPoint' )
				.data( function( d )
				{
					var sCount = d.data.length;  // write the length of the series to each datapoint for reference in animation
					d.data.forEach( function( dp ) { dp.sCount = sCount; } );
					return d.data;
				} )
				.enter().append( "circle" )
					.attr( "class", "dataPoint" )
					.attr( "clip-path", 'url(#' + this.id + '-point-clip-path)' )
					.attr( "r", this.dataPointStyle.radius )
					.attr( "cx", function( d ) { return xScale( self.dataAccessors.x( d ) ); } )
					.attr( "cy", this.ie8Detected ? function( d ) { return yScale( self.dataAccessors.y( d ) ); } : yScale( 0 ) )
					.style( 'stroke-width', this.dataPointStyle.strokeWidth )
					.style( 'fill', this.dataPointStyle.fillColour );

			// animate into position
			if ( !this.ie8Detected )
			{
				points0.selectAll( 'circle.dataPoint' ).transition()
					.duration( function( d ) { return primaryAnimationDuration; } )
					.delay( function( d, i ) { return i * ( secondaryAnimationDuration / d.sCount ); } )
					.attr( "cy", function( d ) { return yScale( self.dataAccessors.y( d )); } );
			}

			// ie8 does not inherit group styling, so go and manually set point stroke colour
			points0.each( function( series, groupIndex )
			{
				d3.select( this ).selectAll( 'circle' )
					.style( 'stroke', function( d ) { var colour = series.colour || colourPalette( groupIndex ); return colour; } );
			} );


			// render our x axis last so it sits on top
			if ( !this.hideAxes ) this.renderAxis( 'x' );

			if ( this.shouldZoom ) this.zoom.x( xScale );
		},


		reRender: function( data )
		{
			// redraw all the elements of the chart, but without animations
			var primaryAnimDuration   = this.primaryAnimationDuration,
				secondaryAnimDuration = this.secondaryAnimationDuration;

			//set anim time to zero
			this.primaryAnimationDuration   = 0;
			this.secondaryAnimationDuration = 0;

			this.canvas.selectAll('*').remove();
			if ( this.renderToolTips )
			{
				this.tooltip.remove();
			}

			// add background back in if not transparent
			if ( this.backgroundColour !== 'transparent' )
			{
				this.chartBackground = this.canvas.append( 'rect' )
					.attr( 'width', this.width + this.padding.left + this.padding.right )
					.attr( 'height', this.height + this.padding.top + this.padding.bottom )
					.attr( 'x', - this.padding.left )
					.attr( 'y', - this.padding.top )
					.attr( 'class', 'chartBackground' )
					.style( 'fill', this.backgroundColour );
			}

			this.render( data );

			// reset animation durations
			this.primaryAnimationDuration   = primaryAnimDuration;
			this.secondaryAnimationDuration = secondaryAnimDuration;

		},


		renderAxis: function( axis )
		{
			var self       = this,
				symbolSize = parseInt( this.yAxisStyle.titleTextSize, 10 ) * 0.6,
				xAxisTitleElement,
				yAxisTitleElement,
				zAxisTitleElement;

			if ( this.xAxis && axis === 'x' )
			{
				if ( this.axisTypes.x === 'linear' ) this.xAxis.tickFormat( this.tickFormatters.x || this.numberFormatterForValues( this.xScale.ticks() ) );

				if ( this.axisShouldHideZeroTicks( axis ) ) this.xAxis.tickValues( this.removeZeroTicks( this.xScale.ticks() ) );

				this.xAxisElement = this.canvas.append( "g" )
					.attr( "class", "x axis" )
					.attr( "transform", function() { var axisPos = self.yScale( 0 ); if ( axisPos > self.height || axisPos < 0 || self.axisTypes.y === 'ordinal' ) axisPos = self.height; return "translate(0," + axisPos + ")"; } )
					.style( "font-family", this.xAxisStyle.textFamily )
					.style( "font-size", this.xAxisStyle.tickTextSize )
					.style( "font-weight", this.xAxisStyle.textWeight )
					.style( "stroke", this.xAxisStyle.tickColour )
					.call( this.xAxis );

				xAxisTitleElement = this.canvas.append( 'text' )
					.attr( 'text-anchor', 'middle' )
					.attr( 'class', 'x-axis-title' )
					.attr( 'transform', 'translate( ' + ( this.width / 2 ) + ',' + ( this.height + this.padding.top + parseInt( this.xAxisStyle.titleTextSize, 10 ) ) + ')' )
					.style( "font-size", this.xAxisStyle.titleTextSize )
					.style( "font-weight", 'bold' )
					.style( 'fill', this.xAxisStyle.titleColour )
					.style( 'stroke', 'none' );

				if ( this.ie8Detected )
				{
					if ( this.xAxisUnit ) xAxisTitleElement.text( this.xAxisTitle + ' (' + this.xAxisUnit + ')' );
					else xAxisTitleElement.text( this.xAxisTitle );
				}
				else
				{
					xAxisTitleElement.append( 'tspan' ).text( this.xAxisTitle );
					if ( this.xAxisUnit ) xAxisTitleElement.append( 'tspan' ).style( "font-weight", 300 ).text( ' (' + this.xAxisUnit + ')' );
				}
			}

			if ( this.yAxis && axis === 'y' )
			{
				if ( this.axisTypes.y === 'linear' ) this.yAxis.tickFormat( this.tickFormatters.y || this.numberFormatterForValues( this.yScale.ticks() ) );

				if ( this.axisShouldHideZeroTicks( axis ) ) this.yAxis.tickValues( this.removeZeroTicks( this.yScale.ticks() ) );

				// render the actual axis itself
				this.yAxisElement = this.canvas.append( "g" )
					.attr( "class", "y axis" )
					.attr( "transform", function() { var axisPos = self.xScale( 0 ); if ( axisPos > self.width || axisPos < 0 || self.axisTypes.x === 'ordinal' || self.axisTypes.x === 'time') axisPos = 0; return "translate(" + axisPos + ", 0)"; } )
					.style( "font-family", this.yAxisStyle.textFamily )
					.style( "font-size", this.yAxisStyle.tickTextSize )
					.style( "font-weight", this.yAxisStyle.textWeight )
					.style( "fill", this.yAxisStyle.tickColour )
					.call( this.yAxis );

				// render the axis title
				yAxisTitleElement = this.canvas.append( 'text' )
					.attr( 'text-anchor', 'middle' )
					.attr( 'class', 'y-axis-title' )
					.attr( 'transform', 'translate( ' +  ( parseInt( this.yAxisStyle.titleTextSize, 10 ) - this.padding.left ) + ',' + ( this.height / 2 ) + ') rotate( -90 )' )
					.style( "font-size", this.yAxisStyle.titleTextSize )
					.style( "font-weight", 'bold' )
					.style( 'fill', this.yAxisStyle.titleColour );

				if ( this.ie8Detected )
				{
					if ( this.yAxisUnit ) yAxisTitleElement.text( this.yAxisTitle + ' (' + this.yAxisUnit + ')' );
					else yAxisTitleElement.text( this.yAxisTitle );
				}
				else
				{
					yAxisTitleElement.append( 'tspan' ).text( this.yAxisTitle );
					if ( this.yAxisUnit ) yAxisTitleElement.append( 'tspan' ).style( "font-weight", 300 ).text( ' (' + this.yAxisUnit + ')' );
				}

				if ( this.yAxisStyle.renderSymbol )
				{
					// render the symbol for the axis
					this.yAxisSymbol = this.yAxisElement.append( 'g' )
						.attr( 'class', 'axis-symbol' )
						.attr( 'transform', 'translate( ' + ( ( 0 - this.padding.left ) + yAxisTitleElement.node().getBBox().height / 2 ) + ',' + ( ( ( this.height / 2 ) + ( yAxisTitleElement.node().getBBox().width / 2 ) ) + 15 ) + ') rotate( -90 )' );

					this.yAxisSymbol.append( 'line' )
						.attr( 'x1', 0 - symbolSize )
						.attr( 'x2', 0 - ( symbolSize / 2 ) )
						.style( 'stroke-width', 2 )
						.style( 'stroke', this.colourPalette( 0 ) )
						.style( 'fill', 'none' );

					this.yAxisSymbol.append( 'line' )
						.attr( 'x1', 0 + ( symbolSize / 2 ) )
						.attr( 'x2', symbolSize )
						.style( 'stroke-width', 2 )
						.style( 'stroke', this.colourPalette( 0 ) )
						.style( 'fill', 'none' );

					this.yAxisSymbol.append( 'circle' )
						.attr( 'r', symbolSize / 2  )
						.style( 'stroke-width', 2 )
						.style( 'stroke', this.colourPalette( 0 ) )
						.style( 'fill', 'none' );
				}

			}

			if ( this.zAxis && axis === 'z' )
			{
				if ( this.axisTypes.z === 'linear' ) this.zAxis.tickFormat( this.tickFormatters.z || this.numberFormatterForValues( this.zScale.ticks() ) );

				if ( this.axisShouldHideZeroTicks( axis ) ) this.zAxis.tickValues( this.removeZeroTicks( this.zScale.ticks() ) );

				// render the axis itself
				this.zAxisElement = this.canvas.append( "g" )
					.attr( "class", "z axis" )
					.attr( "transform", "translate(" + this.width + ",0)" )
					.style( "font-family", this.zAxisStyle.textFamily )
					.style( "font-size", this.zAxisStyle.tickTextSize )
					.style( "font-weight", this.zAxisStyle.textWeight )
					.style( "fill", this.zAxisStyle.tickColour )
					.call( this.zAxis );

				// render the axis symbol
				zAxisTitleElement = this.zAxisElement.append( 'text' )
					.attr( 'text-anchor', 'middle' )
					.attr( 'class', 'title' )
					.attr( 'transform', 'translate( ' + ( this.padding.right - parseInt( this.zAxisStyle.titleTextSize, 10 ) ) + ',' + ( this.height / 2 ) + ') rotate( 90 )' )
					.style( "font-size", this.zAxisStyle.titleTextSize )
					.style( "font-weight", 'bold' )
					.style( 'fill', this.zAxisStyle.titleColour );

				if ( this.ie8Detected )
				{
					if ( this.zAxisUnit ) zAxisTitleElement.text( this.zAxisTitle + ' (' + this.zAxisUnit + ')' );
					else zAxisTitleElement.text( this.zAxisTitle );
				}
				else
				{
					zAxisTitleElement.append( 'tspan' ).text( this.zAxisTitle );
					if ( this.zAxisUnit ) zAxisTitleElement.append( 'tspan' ).style( "font-weight", 300 ).text( ' (' + this.zAxisUnit + ')' );
				}

				if ( this.zAxisStyle.renderSymbol )
				{
					// render the symbol for the axis
					this.zAxisSymbol = this.zAxisElement.append( 'g' )
						.attr( 'class', 'axis-symbol' )
						.attr( 'transform', 'translate( ' + ( this.padding.right - parseInt( this.zAxisStyle.titleTextSize, 10 ) + ( parseInt( this.zAxisStyle.titleTextSize, 10 ) * 0.4 )  ) + ',' + ( ( ( this.height / 2 ) - ( zAxisTitleElement.node().getBBox().width / 2 ) ) - 15 ) + ') rotate( -90 )' );

					this.zAxisSymbol.append( 'line' )
						.attr( 'x1', 0 - symbolSize )
						.attr( 'x2', 0 - ( symbolSize / 2 ) )
						.style( 'stroke-width', 2 )
						.style( 'stroke', this.colourPalette( 1 ) );

					this.zAxisSymbol.append( 'line' )
						.attr( 'x1', 0 + ( symbolSize / 2 ) )
						.attr( 'x2', symbolSize )
						.style( 'stroke-width', 2 )
						.style( 'stroke', this.colourPalette( 1 ) );

					this.zAxisSymbol.append( 'rect' )
						.attr( 'x', 0 - ( symbolSize / 2 )  )
						.attr( 'y', 0 - ( symbolSize / 2 )  )
						.attr( 'width', symbolSize )
						.attr( 'height', symbolSize )
						.style( 'stroke-width', 2 )
						.style( 'stroke', this.colourPalette( 1 ) )
						.style( 'fill', 'none' );
				}
			}

			this.applyAxisStyling();
		},


		renderToolTip: function()
		{
			var pointerSize = 10;
			this.tooltip = d3.select( this.parent ).append("div")
				.attr("class", "tooltip")
				.style( 'position', 'absolute' )
				.style( 'opacity', 1 )
				.style( 'min-width', this.toolTipStyle.width )
				.style( 'padding', this.toolTipStyle.padding )
				.style( 'background-color', this.toolTipStyle.backgroundColour )
				.style( 'border-style', 'solid' )
				.style( 'border-width', this.toolTipStyle.borderWidth + 'px' )
				.style( 'border-color', this.toolTipStyle.borderColour )
				.style( 'border-radius', this.toolTipStyle.borderRadius )
				.style( 'box-shadow', 'box-shadow:0 0 ' + this.toolTipStyle.shadowRadius + 'px ' + this.toolTipStyle.shadowColor)
				.style( 'font-family', this.toolTipStyle.textFamily )
				.style( 'color', this.toolTipStyle.textColour )
				.style( 'text-transform', this.toolTipStyle.textTransform )
				.style( 'opacity', 0 )
				.style( 'pointer-events', 'none' );

			this.tooltipPointer = d3.select( this.parent ).append("div")
				.attr( 'class', 'tooltip-pointer' )
				.style( 'position', 'absolute' )
				.style( 'width', 0 )
				.style( 'height', 0 )
				.style( 'border-top', pointerSize + 'px solid transparent' )
				.style( 'border-left', pointerSize + 'px solid ' + this.toolTipStyle.backgroundColour )
				.style( 'border-bottom', pointerSize + 'px solid transparent' )
				.style( 'opacity', 0 )
				.style( 'pointer-events', 'none' );
		},


		updateAxes: function()
		{
			var self = this;

			if ( this.xAxis && this.axisShouldHideZeroTicks( 'x' ) ) this.xAxis.tickValues( this.removeZeroTicks( this.xScale.ticks() ) );
			if ( this.yAxis && this.axisShouldHideZeroTicks( 'y' ) ) this.yAxis.tickValues( this.removeZeroTicks( this.yScale.ticks() ) );
			if ( this.zAxis && this.axisShouldHideZeroTicks( 'z' ) ) this.zAxis.tickValues( this.removeZeroTicks( this.zScale.ticks() ) );
			if ( !this.ie8Detected )
			{
				if ( this.xAxis )
				{
					this.canvas.select( 'g.x.axis' ).transition().duration( this.primaryAnimationDuration )
						.attr( "transform", function() { var axisPos = self.yScale( 0 ); if ( axisPos > self.height || axisPos < 0 ) axisPos = self.height; return "translate(0," + axisPos + ")"; } )
						.call( this.xAxis );
				}

				if ( this.yAxis )
				{
					this.canvas.select( 'g.y.axis' ).transition().duration( this.primaryAnimationDuration )
						.attr( "transform", function() { var axisPos = self.xScale( 0 ); if ( axisPos > self.width || axisPos < 0 || self.axisTypes.x === 'ordinal' || self.axisTypes.x === 'time' ) axisPos = 0; return "translate(" + axisPos + ", 0)"; } )
						.call( this.yAxis );
				}

				if ( this.zAxis )
				{
					this.canvas.select( 'g.z.axis' ).transition().duration( this.primaryAnimationDuration )
						.call( this.zAxis );
				}
			}
			else
			{
				if ( this.xAxis )
				{
					this.canvas.select( 'g.x.axis' )
						.attr( "transform", function() { var axisPos = self.yScale( 0 ); if ( axisPos > self.height || axisPos < 0 ) axisPos = self.height; return "translate(0," + axisPos + ")"; } )
						.call( this.xAxis );
				}

				if ( this.yAxis )
				{
					this.canvas.select( 'g.y.axis' )
						.attr( "transform", function() { var axisPos = self.xScale( 0 ); if ( axisPos > self.width || axisPos < 0 || self.axisTypes.x === 'ordinal' || self.axisTypes.x === 'time' ) axisPos = 0; return "translate(" + axisPos + ", 0)"; } )
						.call( this.yAxis );
				}

				if ( this.zAxis )
				{
					this.canvas.select( 'g.z.axis' )
						.call( this.zAxis );
				}
			}
		},


		repositionAxes: function()
		{
			var self = this;

			// axes themselves
			this.canvas.select( 'g.x.axis' ).attr( "transform", function() { var axisPos = self.yScale( 0 ); if ( axisPos > self.height || axisPos < 0 || self.axisTypes.y === 'ordinal') axisPos = self.height; return "translate(0," + axisPos + ")"; } );
			this.canvas.select( 'g.y.axis' ).attr( "transform", function() { var axisPos = self.xScale( 0 ); if ( axisPos > self.width || axisPos < 0 || self.axisTypes.x === 'ordinal' || self.axisTypes.x === 'time' ) axisPos = 0; return "translate(" + axisPos + ", 0)"; } );

			// titles
			this.canvas.select( '.x-axis-title' ).attr( 'transform', 'translate( ' + ( this.width / 2 ) + ',' + ( this.height + this.padding.top + parseInt( this.xAxisStyle.titleTextSize, 10 ) ) + ')' );
			this.canvas.select( '.y-axis-title' ).attr( 'transform', 'translate( ' +  ( parseInt( this.yAxisStyle.titleTextSize, 10 ) - this.padding.left ) + ',' + ( this.height / 2 ) + ') rotate( -90 )' );
			this.canvas.select( '.z-axis-title' ).attr( 'transform', 'translate( ' + ( this.padding.right - parseInt( this.zAxisStyle.titleTextSize, 10 ) ) + ',' + ( this.height / 2 ) + ') rotate( 90 )' );
		},


		renderZeroLine: function( axis )
		{
			// render floating zero-lines
			if ( axis === 'x' )
			{
				this.xZeroLine = this.canvas.append( 'line' )
					.attr( 'class', 'x zeroline')
					.attr( "clip-path", 'url(#' + this.id + '-chart-area)' )
					.attr( 'x1', this.xScale( 0 ) )
					.attr( 'y1', 0 )
					.attr( 'x2', this.xScale( 0 ) )
					.attr( 'y2', this.height )
					.style( "stroke", this.xAxisStyle.lineColour )
					.style( 'stroke-width', 1 );
			}
			else if ( axis === 'y' )
			{
				this.yZeroLine = this.canvas.append( 'line' )
					.attr( 'class', 'y zeroline')
					.attr( "clip-path", 'url(#' + this.id + '-chart-area)' )
					.attr( 'x1', 0 )
					.attr( 'y1', this.yScale( 0 ) )
					.attr( 'x2', this.width )
					.attr( 'y2', this.yScale( 0 ) )
					.style( "stroke", this.xAxisStyle.lineColour )
					.style( 'stroke-width', 1 );
			}
		},


		updateZeroLines: function()
		{
			if ( this.xZeroLine )
			{
				this.xZeroLine.transition().duration( this.primaryAnimationDuration )
					.attr( 'x1', this.xScale( 0 ) )
					.attr( 'x2', this.xScale( 0 ) );
			}
			if ( this.yZeroLine )
			{
				this.yZeroLine.transition().duration( this.primaryAnimationDuration )
					.attr( 'y1', this.yScale( 0 ) )
					.attr( 'y2', this.yScale( 0 ) );
			}
		},


		renderGridLines: function( axis )
		{
			this.gridLines = this.canvas.append( 'g' )
					.attr( 'class', 'gridlines' );


			if ( axis === 'x' )
			{
				this.gridLines.selectAll( "line.x" )
				.data( this.xScale.ticks( this.xAxisStyle.tickCount ) )
					.enter().append( "line" )
						.attr( "class", "x grid-line" )
						.attr( "clip-path", 'url(#' + this.id + '-chart-area)' )
						.attr( "x1", this.xScale )
						.attr( "x2", this.xScale )
						.attr( "y1", 0 )
						.attr( "y2", this.height )
						.attr( 'stroke-dasharray', this.gridLineStyle.dashArray )
						.style( 'stroke', this.gridLineStyle.colour )
						.style( 'shape-rendering', 'crispedges' );
			}
			else if ( axis === 'y' )
			{
				this.gridLines.selectAll( "line.y" )
				.data( this.yScale.ticks( Math.round( this.height / 80 ) ) )
					.enter().append( "line" )
						.attr( "class", "y grid-line" )
						.attr( "clip-path", 'url(#' + this.id + '-chart-area)' )
						.attr( "x1", 0 )
						.attr( "x2", this.width )
						.attr( "y1", this.yScale )
						.attr( "y2", this.yScale )
						.attr( 'stroke-dasharray', this.gridLineStyle.dashArray )
						.style( 'stroke', this.gridLineStyle.colour )
						.style( 'shape-rendering', 'crispedges' );
			}
			else
			{
				this.gridLines.selectAll( "line.z" )
				.data( this.zScale.ticks( Math.round( this.height / 80 ) ) )
					.enter().append( "line" )
						.attr( "class", "z grid-line" )
						.attr( "clip-path", 'url(#' + this.id + '-chart-area)' )
						.attr( "x1", 0 )
						.attr( "x2", this.width )
						.attr( "y1", this.zScale )
						.attr( "y2", this.zScale )
						.attr( 'stroke-dasharray', this.gridLineStyle.dashArray )
						.style( 'stroke', this.gridLineStyle.colour )
						.style( 'shape-rendering', 'crispedges' );
			}
		},


		updateGridLines: function( axis )
		{
			var xUpdateSelection,
				yUpdateSelection,
				zUpdateSelection;

			if ( axis === 'x' )
			{
				// x gridlines
				xUpdateSelection = this.gridLines.selectAll( "line.x.grid-line" )
					.data( this.xScale.ticks( this.xAxisStyle.tickCount ) );

				xUpdateSelection.enter().append( "line" )
					.attr( "clip-path", 'url(#' + this.id + '-chart-area)' )
					.attr( "class", "x grid-line" )
					.attr( "x1", this.xScale )
					.attr( "x2", this.xScale )
					.attr( "y1", this.height )
					.attr( "y2", this.height )
					.attr( 'stroke-dasharray', this.gridLineStyle.dashArray )
					.style( 'stroke', this.gridLineStyle.colour );

				xUpdateSelection.transition()
					.duration( this.primaryAnimationDuration )
						.attr( "x1", this.xScale )
						.attr( "x2", this.xScale )
						.attr( "y1", 0 );

				xUpdateSelection.exit()
					.transition().duration( this.primaryAnimationDuration )
						.attr( "x1", this.xScale )
						.attr( "x2", this.xScale )
						.remove();
			}
			else if ( axis === 'y' )
			{
				// y gridlines
				yUpdateSelection = this.gridLines.selectAll( "line.y.grid-line" )
					.data( this.yScale.ticks( Math.floor( this.height / 80 ) ) );

				yUpdateSelection.enter().append( "line" )
					.attr( "clip-path", 'url(#' + this.id + '-chart-area)' )
					.attr( "class", "y grid-line" )
					.attr( "x1", this.width )
					.attr( "x2", this.width )
					.attr( "y1", this.yScale )
					.attr( "y2", this.yScale )
					.attr( 'stroke-dasharray', this.gridLineStyle.dashArray )
					.style( 'stroke', this.gridLineStyle.colour );

				yUpdateSelection.transition()
					.duration( this.primaryAnimationDuration )
						.attr( "y1", this.yScale )
						.attr( "y2", this.yScale )
						.attr( "x1", 0 );

				yUpdateSelection.exit()
					.transition().duration( this.primaryAnimationDuration )
						.attr( "y1", this.yScale )
						.attr( "y2", this.yScale )
						.remove();
			}
			else if ( axis === 'z' )
			{
				// z gridlines
				zUpdateSelection = this.gridLines.selectAll( "line.z.grid-line" )
					.data( this.zScale.ticks( Math.floor( this.height / 80 ) ) );

				zUpdateSelection.enter().append( "line" )
					.attr( "clip-path", 'url(#' + this.id + '-chart-area)' )
					.attr( "class", "z grid-line" )
					.attr( "x1", this.width )
					.attr( "x2", this.width )
					.attr( "y1", this.zScale )
					.attr( "y2", this.zScale )
					.attr( 'stroke-dasharray', this.gridLineStyle.dashArray )
					.style( 'stroke', this.gridLineStyle.colour );

				zUpdateSelection.transition()
					.duration( this.primaryAnimationDuration )
						.attr( "y1", this.zScale )
						.attr( "y2", this.zScale )
						.attr( "x1", 0 );

				zUpdateSelection.exit()
					.transition().duration( this.primaryAnimationDuration )
						.attr( "y1", this.zScale )
						.attr( "y2", this.zScale )
						.remove();
			}
		},


		applyAxisStyling: function()
		{
			// style axis with colours
				this.canvas.selectAll( 'g.x.axis' ).selectAll( 'g.tick text' ).style( "fill", this.xAxisStyle.textColour );
				this.canvas.selectAll( 'g.y.axis' ).selectAll( 'g.tick text' ).style( "fill", this.yAxisStyle.textColour );
				this.canvas.selectAll( 'g.z.axis' ).selectAll( 'g.tick text' ).style( "fill", this.zAxisStyle.textColour );

				this.canvas.selectAll( 'g.axis' ).selectAll( 'g.tick text' ).style( "stroke", "none" );


				this.canvas.selectAll( 'g.x.axis' ).selectAll( 'text.title' ).style( "fill", this.xAxisStyle.titleColour );
				this.canvas.selectAll( 'g.y.axis' ).selectAll( 'text.title' ).style( "fill", this.yAxisStyle.titleColour );
				this.canvas.selectAll( 'g.z.axis' ).selectAll( 'text.title' ).style( "fill", this.zAxisStyle.titleColour );

				this.canvas.selectAll( 'g.x.axis' ).selectAll( 'path.domain' ).style( "stroke", this.xAxisStyle.lineColour );
				this.canvas.selectAll( 'g.y.axis' ).selectAll( 'path.domain' ).style( "stroke", this.yAxisStyle.lineColour );
				this.canvas.selectAll( 'g.z.axis' ).selectAll( 'path.domain' ).style( "stroke", this.zAxisStyle.lineColour );

				this.canvas.selectAll( 'g.axis' ).selectAll( 'path' ).style( "fill", 'none' );

				this.canvas.selectAll( 'g.x.axis' ).selectAll( 'g.tick line' ).style( "stroke", this.xAxisStyle.tickColour );
				this.canvas.selectAll( 'g.y.axis' ).selectAll( 'g.tick line' ).style( "stroke", this.yAxisStyle.tickColour );
				this.canvas.selectAll( 'g.z.axis' ).selectAll( 'g.tick line' ).style( "stroke", this.zAxisStyle.tickColour );
		},


		halt: function()
		{
			// store the existing values temporarily
			var primaryAnimDuration   = this.primaryAnimDuration,
				secondaryAnimDuration = this.secondaryAnimDuration;
			// set our durations to zero
			this.primaryAnimDuration = 0;
			this.secondaryAnimationDuration = 0;

			// call update with the new zero durations
			this.updateData( this.data );

			// restore our animation durations
			this.primaryAnimDuration = primaryAnimDuration;
			this.secondaryAnimationDuration = secondaryAnimDuration;
		},


		renderBrush: function( data )
		{
			var xScale = this.brush.xScale,
				yScale = this.brush.yScale,
				brushLineConstructor,
				brushSeries,
				backgroundBrushLines,
				foregroundBrushLines,
				brushGroup,
				brushClipRect;

			// draw clip rect for brush lines
			brushClipRect = this.brush.canvas.append( 'clipPath' )
				.attr( 'id', 'brushClipRect' )
				.append( 'rect' )
					.attr( 'width', this.brushOptions.dimensions.width )
					.attr( 'height', this.brushOptions.dimensions.height );

			this.brush.clipRect = brushClipRect;

			// brush canvas background
			this.brush.canvas.append( 'rect' )
				.attr( 'class', 'background' )
				.attr( "clip-path", 'url(#brushClipRect)' )
				.attr( 'width', this.brushOptions.dimensions.width )
				.attr( 'height', this.brushOptions.dimensions.height )
				.style( 'fill', this.brushOptions.focusBackgroundColour );


			/*     CHART SPECIFIC    */

			//this.renderChartInBrush( data );

			// render an axis in the brush
			this.brushScale = this.xScale.copy();
			this.brushScale.range( [ 0, this.brushOptions.dimensions.width - ( 2 * this.brushOptions.handles.width ) ] );

			this.brushAxis = d3.svg.axis()
				.scale( this.brushScale )
				.orient( 'top' )
				.tickSize( 35, 4, 35 )
				.tickSubdivide( 8 )
				.tickFormat( this.tickFormatForAxisType( this.axisTypes.x ) );

			this.brushAxisElement = this.brush.canvas.append( 'g' )
				.style( 'fill', 'none' )
				.style( 'stroke', '#999999' )
				.call( this.brushAxis )
				.attr( 'transform', 'translate(' + this.brushOptions.handles.width + ',' + ( this.brushOptions.dimensions.height - 5 )+ ')' );

			this.brushAxisElement.selectAll( 'text' )
				.attr( 'dy', 22 )
				.attr( 'x', 5 )
				.style( 'font-size', '11px' )
				.style( 'font-weight', 'bold' )
				.style( 'text-anchor', 'start' )
				.style( 'stroke', 'none' )
				.style( 'fill', 'white' );

			/*     END CHART SPECIFIC    */

			// group which contains the brush elements which we will interact with
			brushGroup = this.brush.canvas.append( 'g' )
				.attr( 'class', 'x brush' )
				.call( this.brush.constructor );

			// set all the elements to the height of the brush area
			brushGroup.selectAll( 'rect' )
				.attr( 'y', 0 )
				.attr( 'height', this.brushOptions.dimensions.height );


			// create a pair of rects which will cover the out of focus areas, idea being that they are semi-opaque and will provide a shading effect

			// left shader first
			this.brush.leftShader = brushGroup.append( 'rect' )
				.attr( 'width', this.brush.xScale( this.brush.constructor.extent()[0] ) )
				.attr( 'height', this.brushOptions.dimensions.height )
				.style( 'fill', 'black' )
				.style( 'opacity', this.brushOptions.shadeOpacity );

			// then the right
			this.brush.rightShader = brushGroup.append( 'rect' )
				.attr( 'width', 0 )
				.attr( 'transform', 'translate( ' + this.brush.xScale( this.brush.constructor.extent()[1] ) + ', 0 )' )
				.attr( 'height', this.brushOptions.dimensions.height )
				.style( 'fill', 'black' )
				.style( 'opacity', this.brushOptions.shadeOpacity );

			// create some touch-friendly handles for the brush with the image specified in the brushOptions

			// create the left hand side (or western) handle
			brushGroup.selectAll( ".resize.w" ).append( "image" )
				.attr( 'width', this.brushOptions.handles.width )
				.attr( 'height', this.brushOptions.dimensions.height )
				.attr( 'preserveAspectRatio', 'none' )
				.attr( 'xlink:href', this.brushOptions.handles.image );

			// create the right hand side (or eastern) handle
			brushGroup.selectAll( ".resize.e" ).append( "image" )
				.attr( "transform", "translate( " + -this.brushOptions.handles.width + ", 0 )" )
				.attr( 'width', this.brushOptions.handles.width )
				.attr( 'height', this.brushOptions.dimensions.height )
				.attr( 'preserveAspectRatio', 'none' )
				.attr( 'xlink:href', this.brushOptions.handles.image );

			brushGroup.selectAll( '.background' ).attr( 'opacity', 0 );

		},


		renderChartInBrush: function( data )
		{
			// override this on a chart by chart basis
		},


		updateData: function( newData, animated )
		{

			// override this function to update your chart

			// as a fallback in case our child class does not define this method, re-render which removes all elements from the chart and calls render again
			this.reRender( newData );
		},


		sort: function( axis, ascending )
		{

			// override this function to sort your chart
		},


		/*****Event Handling Functions******/

		/*
			brushed function which is called whenever the user moves or interacts with the focus brush

			this function takes care of altering the scales of the graph and resizing the brush elements
		*/
		brushed: function ()
		{
			var xScale = this.xScale;
			// set the x domain
			xScale.domain( this.brush.constructor.empty() ? this.brush.xScale.domain() : this.brush.constructor.extent() );

			// alter the position of the graph elements with relation to the updated xScale
			this.redraw();

			// shift the brush shader elements
			this.brush.leftShader.attr( 'width', this.brush.xScale( this.brush.constructor.extent()[ 0 ] ) );

			this.brush.rightShader.attr( 'width', this.brushOptions.dimensions.width - this.brush.xScale( this.brush.constructor.extent()[ 1 ] ) )
				.attr( 'transform', 'translate( ' + this.brush.xScale( this.brush.constructor.extent()[ 1 ] ) + ', 0 )' );

			// also resize the clipping rect which give our focus effect on the brush area
			this.brush.clipRect.attr( 'width', this.brush.xScale( this.brush.constructor.extent()[ 1 ] ) - this.brush.xScale( this.brush.constructor.extent()[ 0 ] ) )
				.attr( 'transform', 'translate( ' + this.brush.xScale( this.brush.constructor.extent()[ 0 ] ) + ', 0 )' );

			/*
			if ( this.shouldScrub && this.scrubIndicator.nearestDataPoints !== undefined )  // if nowhere has been scrubbed yet, nearestDataPoints will be undefined
			{
				// move the scrub indicator to the new pos
				this.scrubIndicator.scrubLine.style( 'left', this.xScale( this.scrubIndicator.nearestDataPoints[ 0 ].timeStamp ) + 'px' );
			}*/
		},


		zoomScale: function()
		{
			if ( this.zoom ) return this.zoom.scale();
			else return 1;
		},


		zoomToScale: function( scale )
		{
			if ( this.shouldZoom )
			{
				this.zoom.scale( scale );
				this.redraw();
			}
		},


		translation: function()
		{
			if ( this.zoom ) return this.zoom.translate();
			else return [ 0, 0 ];
		},


		translateToVector: function( vector )
		{
			if ( this.shouldZoom )
			{
				this.zoom.translate( vector );
				this.redraw();
			}
		},


		redraw: function()
		{
			var self            = this,
			    xScale          = this.xScale,
			    yScale          = this.yScale,
			    zScale          = this.zScale,
			    dataPointStyle  = this.dataPointStyle,
				lineConstructor = this.lineConstructor,
				areaConstructor = this.areaConstructor;

			// apply new size to scales
			this.xScale.range( [ 0, this.width ] );
			this.yScale.range( [ this.height, 0] );

			// dataPoints
			this.canvas.selectAll( 'circle.dataPoint' )
				.attr( "cx", function( d ) { return xScale( self.dataAccessors.x( d ) ); } )
				.attr( "cy", function( d ) { return yScale( self.dataAccessors.y( d ) ); } );

			this.canvas.selectAll( 'rect.dataPoint' )
				.attr( "x", function( d ) { return xScale( self.dataAccessors.x( d ) ) - dataPointStyle.radius; } )
				.attr( "y", function( d ) { return zScale( self.dataAccessors.z( d ) )  - dataPointStyle.radius; } );


			// lines
			this.canvas.selectAll( '.series0 path.dataLine' ).attr( "d", function( d ) { return lineConstructor( d.data ); } );

			//swap for z axis
			lineConstructor.y( function( d ) { return zScale( self.dataAccessors.z( d ) ); } );
			this.canvas.selectAll( '.series1 path.dataLine' ).attr( "d", function( d ) { return lineConstructor( d.data ); } );

			//swap back
			lineConstructor.y( function( d ) { return yScale( self.dataAccessors.y( d ) ); } );

			// fill areas
			this.canvas.selectAll( '.series0 path.dataFill' ).attr( "d", function( d ) { return areaConstructor( d.data ); } );

			//swap for z axis
			areaConstructor.y( function( d ) { return zScale( self.dataAccessors.z( d ) ); } );
			this.canvas.selectAll( '.series1 path.dataFill' ).attr( "d", function( d ) { return areaConstructor( d.data ); } );

			//swap back
			areaConstructor.y( function( d ) { return yScale( self.dataAccessors.y( d ) ); } );

			// redraw axis
			this.canvas.select( 'g.x.axis' ).call( this.xAxis );
			this.canvas.select( 'g.x.axis' ).attr( "transform", function() { var axisPos = self.yScale( 0 ); if ( axisPos > self.height || axisPos < 0 ) axisPos = self.height; return "translate(0," + axisPos + ")"; } );
			this.canvas.select( 'g.y.axis' ).call( this.yAxis );
			if ( this.zAxis ) this.canvas.select( 'g.z.axis' ).call( this.zAxis );


			// style axis
			this.applyAxisStyling();

			// update gridLines
			if ( !this.hideGridLines )
			{
				this.gridLines.selectAll( "line.y.gridLine" )
						.attr( "y1", this.yScale )
						.attr( "y2", this.yScale );

				this.gridLines.selectAll( "line.x.gridLine" )
						.attr( "x1", this.xScale )
						.attr( "x2", this.xScale );
			}
		},


		unload: function()
		{
			// unbind resize event
			d3.select( window ).on( 'resize.' + this.id, null );
		},


		scrubbed: function ( scrubPos )
		{
			var indicatorPos     = 0,
			    tooltipPos       = { x:0, y:0 },
			    pointerPos       = { x:0, y:0 },
			    verticalOverflow = 0,
			    nearestXYPoints  = [],
			    nearestXZPoints  = [],
			    nearestYPoints   = [],
			    nearestZPoints   = [],
			    tooltipHeight;

			// check if position is within chart area
			if ( scrubPos[0] >= 0 && scrubPos[0] <= this.width && scrubPos[1] >= 0 && scrubPos[1] <= this.height )
			{
				// convert x position into nearest data point(s)

				// invert the xpos to position on our scale and find neareast actual datapoints
				nearestXYPoints = this.findNearestXValue( this.xScale.invert( scrubPos[0] ), this.dataByXValue );

				// filter to only points within x radius
				nearestXYPoints = this.dataPointsWithinXPixels( scrubPos[0], nearestXYPoints, this.toolTipStyle.detectionRadius );

				// filter to only points within y radius
				nearestYPoints = this.dataPointsWithinYPixels( scrubPos[1], nearestXYPoints, this.toolTipStyle.detectionRadius );

				// do the same for triple axis datasets
				if ( this.isTripleAxis )
				{
					nearestXZPoints = this.findNearestXValue( this.xScale.invert( scrubPos[0] ), this.zDataByXValue );
					nearestZPoints = this.dataPointsWithinZPixels( scrubPos[1], nearestXZPoints, this.toolTipStyle.detectionRadius );
				}


				if ( nearestYPoints.length > 0 )
				{
					// generate the html contents from the datapoints
					this.tooltip.html( this.dataToToolTipHTML( nearestYPoints ) );

					// calculate preliminary positions of tooltip and pointer
					tooltipPos.x = this.dataPosAccessors.x( nearestYPoints[ 0 ] ) + this.padding.left + ( 2 * parseInt( this.toolTipStyle.padding, 10 ) );
					tooltipPos.y = ( 30 + this.padding.top + this.dataPosAccessors.y( nearestYPoints[ 0 ] ) ) - ( parseInt( this.tooltip.style( 'height' ), 10 ) / 2 ) - parseInt( this.toolTipStyle.padding, 10 );

					pointerPos.x = this.dataPosAccessors.x( nearestYPoints[ 0 ] );
					pointerPos.y = this.dataPosAccessors.y( nearestYPoints[ 0 ] );

					// if we are viewing data on the right hand side of the chart...
					if ( scrubPos[0] >= this.width / 2 )
					{
						// offset tooltip by its own width
						tooltipPos.x = tooltipPos.x - parseInt( this.tooltip.style( 'width' ), 10 ) - 44 - 5;

						// set pointer to right-facing orientation
						this.tooltipPointer.style( '-webkit-transform', 'scale( 1, 1 )' );

						// offset by pointer dimensions
						pointerPos.x -= this.toolTipStyle.pointerSize;
						pointerPos.y -= this.toolTipStyle.pointerSize;
					}
					else
					{
						// move the pointer element, flipped orientation
						this.tooltipPointer.style( '-webkit-transform', 'scale( -1, 1 )' );

						// offset by pointer dimensions
						pointerPos.y -= this.toolTipStyle.pointerSize;
					}

					// check to make sure tooltip doesn't flow over the top of bottom of the chart
					tooltipHeight = parseInt( this.tooltip.style( 'height' ), 10 ) + ( parseInt( this.toolTipStyle.padding, 10 ) * 2 );

					// calculate amount by which the tooltip overflows, don't forget to adjust for padding!
					verticalOverflow = ( tooltipPos.y + tooltipHeight ) - ( this.height + this.padding.top + parseInt( d3.select( this.parent.parentNode ).style( 'padding-top' ), 10 ) + this.toolTipStyle.pointerSize );
					if (  verticalOverflow > 0 ) tooltipPos.y -= verticalOverflow;

					// apply position to tooltip
					this.tooltip.style( 'left', tooltipPos.x + 'px' );
					this.tooltip.style( 'top', tooltipPos.y + 'px' );

					// translate pointer pos back to html coordinates
					this.tooltipPointer.style( 'left', this.chartPosToParentPos( [ pointerPos.x, pointerPos.y ] )[0] + 'px' );
					this.tooltipPointer.style( 'top', this.chartPosToParentPos( [ pointerPos.x, pointerPos.y ] )[1] + 'px' );

					// make tooltip and pointer visible
					this.tooltip.style( 'opacity', 1 );
					this.tooltipPointer.style( 'opacity', 1 );
				}
				else if ( nearestZPoints.length > 0 )
				{
					// generate the html contents from the datapoints
					this.tooltip.html( this.dataToToolTipHTML( nearestZPoints ) );

					// calculate preliminary positions of tooltip and pointer
					tooltipPos.x = this.dataPosAccessors.x( nearestZPoints[ 0 ] ) + this.padding.left + ( 2 * parseInt( this.toolTipStyle.padding, 10 ) );
					tooltipPos.y = ( 30 + this.padding.top + this.dataPosAccessors.z( nearestZPoints[ 0 ] ) ) - ( parseInt( this.tooltip.style( 'height' ), 10 ) / 2 ) - parseInt( this.toolTipStyle.padding, 10 );

					pointerPos.x = this.dataPosAccessors.x( nearestZPoints[ 0 ] );
					pointerPos.y = this.dataPosAccessors.z( nearestZPoints[ 0 ] );

					// if we are viewing data on the right hand side of the chart...
					if ( scrubPos[0] >= this.width / 2 )
					{
						// offset tooltip by its own width
						tooltipPos.x = tooltipPos.x - parseInt( this.tooltip.style( 'width' ), 10 ) - 44 - 5;

						// set pointer to right-facing orientation
						this.tooltipPointer.style( '-webkit-transform', 'scale( 1, 1 )' );

						// offset by pointer dimensions
						pointerPos.x -= this.toolTipStyle.pointerSize;
						pointerPos.y -= this.toolTipStyle.pointerSize;
					}
					else
					{
						// move the pointer element, flipped orientation
						this.tooltipPointer.style( '-webkit-transform', 'scale( -1, 1 )' );

						// offset by pointer dimensions
						pointerPos.y -= this.toolTipStyle.pointerSize;
					}

					// check to make sure tooltip doesn't flow over the top of bottom of the chart
					tooltipHeight = parseInt( this.tooltip.style( 'height' ), 10 ) + ( parseInt( this.toolTipStyle.padding, 10 ) * 2 );

					// calculate amount by which the tooltip overflows, don't forget to adjust for padding!
					verticalOverflow = ( tooltipPos.y + tooltipHeight ) - ( this.height + this.padding.top + parseInt( d3.select( this.parent.parentNode ).style( 'padding-top' ), 10 ) + this.toolTipStyle.pointerSize );
					if (  verticalOverflow > 0 ) tooltipPos.y -= verticalOverflow;

					// apply position to tooltip
					this.tooltip.style( 'left', tooltipPos.x + 'px' );
					this.tooltip.style( 'top', tooltipPos.y + 'px' );

					// translate pointer pos back to html coordinates
					this.tooltipPointer.style( 'left', this.chartPosToParentPos( [ pointerPos.x, pointerPos.y ] )[0] + 'px' );
					this.tooltipPointer.style( 'top', this.chartPosToParentPos( [ pointerPos.x, pointerPos.y ] )[1] + 'px' );

					// make tooltip and pointer visible
					this.tooltip.style( 'opacity', 1 );
					this.tooltipPointer.style( 'opacity', 1 );
				}
				else
				{
					this.tooltip.style( 'opacity', 0 );
					this.tooltipPointer.style( 'opacity', 0 );
				}
			}
			else
			{
				this.tooltip.style( 'opacity', 0 );
				this.tooltipPointer.style( 'opacity', 0 );
			}
		},


		parentPosToChartPos: function( origPos )
		{
			return [ origPos[0] - this.padding.left, origPos[1] - this.padding.top ];
		},


		chartPosToParentPos: function( origPos )
		{
			return [ origPos[0] + this.padding.left + parseInt( d3.select( this.parent.parentNode ).style( 'padding-left' ), 10 ), origPos[1] + this.padding.top + parseInt( d3.select( this.parent.parentNode ).style( 'padding-top' ), 10 ) ];
		},


		nearestYDataPoints: function( yPos, allDataPoints, number )
		{
			var i                = 0,
			    pointsByDistance = [],
			    nearestPoints    = [],
			    distance;

			// calculate distance from cursor of all points
			for ( i = 0; i < allDataPoints.length; i ++ )
			{
				distance = Math.abs( this.dataPosAccessors.y( allDataPoints[i] ) - yPos );
				pointsByDistance.push( { distance:distance, dataPoint:allDataPoints[i] } );
			}

			// sort by distance
			pointsByDistance.sort( function( a, b )
			{
			    a = a.distance;
			    b = b.distance;
			    return a > b ? -1 : a < b ? 1 : 0;
			} );

			// cherry pick the top number of points
			number = number <= pointsByDistance.length ? number : pointsByDistance.length;

			for ( i = 0; i < number; i ++ )
			{
				nearestPoints.push( pointsByDistance[ ( pointsByDistance.length - 1 ) - i ].dataPoint );
			}

			// sort alphabetically
			nearestPoints.sort( function( a, b )
			{
				a = a.seriesName;
			    b = b.seriesName;
			    return a > b ? 1 : a < b ? -1 : 0;
			} );

			return nearestPoints;
		},


		dataPointsWithinXPixels: function( xPos, allDataPoints, maxDistance )
		{
			var self          = this,
			    i             = 0,
			    pointsInRange = [],
			    distance;

			// find any points in range
			for ( i = 0; i < allDataPoints.length; i ++ )
			{
				distance = Math.abs( this.dataPosAccessors.x( allDataPoints[i] ) - xPos );
				if ( distance <= maxDistance ) pointsInRange.push( allDataPoints[i] );
			}

			// sort by xPos
			pointsInRange.sort( function( a, b )
			{
			    a = self.dataPosAccessors.x( a );
			    b = self.dataPosAccessors.x( b );
			    return a > b ? 1 : a < b ? -1 : 0;
			} );

			return pointsInRange;
		},


		dataPointsWithinYPixels: function( yPos, allDataPoints, maxDistance )
		{
			var self          = this,
			    i             = 0,
			    pointsInRange = [],
			    distance;

			// find any points in range
			for ( i = 0; i < allDataPoints.length; i ++ )
			{
				distance = Math.abs( this.dataPosAccessors.y( allDataPoints[i] ) - yPos );
				if ( distance <= maxDistance ) pointsInRange.push( allDataPoints[i] );
			}

			// sort by yPos
			pointsInRange.sort( function( a, b )
			{
			    a = self.dataPosAccessors.y( a );
			    b = self.dataPosAccessors.y( b );
			    return a > b ? 1 : a < b ? -1 : 0;
			} );

			return pointsInRange;
		},


		dataPointsWithinZPixels: function( zPos, allDataPoints, maxDistance )
		{
			var self          = this,
			    i             = 0,
			    pointsInRange = [],
			    distance;

			// find any points in range
			for ( i = 0; i < allDataPoints.length; i ++ )
			{
				distance = Math.abs( this.dataPosAccessors.z( allDataPoints[i] ) - zPos );
				if ( distance <= maxDistance ) pointsInRange.push( allDataPoints[i] );
			}

			// sort by zPos
			pointsInRange.sort( function( a, b )
			{
			    a = self.dataPosAccessors.z( a );
			    b = self.dataPosAccessors.z( b );
			    return a > b ? 1 : a < b ? -1 : 0;
			} );

			return pointsInRange;
		},


		dataToToolTipHTML: function( data )
		{
			var i      = 0,
			    string = '';
			for ( i = 0; i < data.length; i++ )
			{
				string += '<h3>' + data[ i ].seriesName + '</h3><br>';
				string += '<h2>' + this.numberFormatter( this.dataAccessors.y( data[ i ] ) ) + '</h2><br>';
			}

			return string;
		},


		/*****Customisation Functions******/

		setDimensions: function( dimensions )
		{
			this.dimensions = dimensions;

			this.width  = this.dimensions.width - this.padding.left - this.padding.right;
			this.height = this.dimensions.height - this.padding.top - this.padding.bottom;

			// resize clip path
			this.clipPath.attr( "width", this.width )
				.attr( "height", this.height );

			this.redraw();
		},


		setColourPalette: function( colours )
		{
			if ( colours.length )
			{
				this.colourPalette = d3.scale.ordinal()
					.range( colours );
			}
			else
			{
				// Error: tried to set new colour palette with no colours
			}
		},


		setInterpolationMode: function( mode )
		{
			// controls whether or not we apply line smoothing on things like area charts or line charts
			this.interpolation = mode;
		},


		setPadding: function( padding )
		{
			this.padding = padding;
			this.width  = this.dimensions.width - this.padding.left - this.padding.right;
			this.height = this.dimensions.height - this.padding.top - this.padding.bottom;

			this.canvas.attr( "transform", "translate(" + this.padding.left + "," + this.padding.top + ")" );

			if ( this.chartBackground ) this.chartBackground.attr( 'x', -this.padding.left ).attr( 'y', -this.padding.top );
		},


		/********Helper Functions**********/

		resizeToFitParent: function()
		{
			// resize svg and canvas
			var newWidth  = parseInt( d3.select( this.parent ).style( 'width' ), 10 ),
				newHeight = parseInt( d3.select( this.parent ).style( 'height' ), 10 );

			d3.select( this.parent ).select( 'svg' ).attr( 'width', newWidth );
			d3.select( this.parent ).select( 'svg' ).attr( 'height', newHeight );

			this.setDimensions( { width:newWidth, height:newHeight } );
		},


		sizeOfTextWithFontSizeAndFamily: function( text, fontSize, fontFamily )
		{
			// create
			var canvas  = d3.select( this.parent ).append( 'canvas' ),
			    context = canvas.node().getContext( '2d' ),
			    size;

			// set context font settings
			context.font = fontSize + ' ' + fontFamily;
			size = context.measureText( text );

			// remove canvas
			// somehow?

			return size;
		},


		scaleForType: function( type )
		{
			if ( type === "time" )
			{
				return d3.time.scale();
			}
			else if ( type === "ordinal" )
			{
				return d3.scale.ordinal();
			}
			else if ( type === "linear" )
			{
				return d3.scale.linear();
			}
			else if ( type === "sqrt" )
			{
				return d3.scale.sqrt();
			}
		},


		defaultAccessorForAxisType: function ( type )
		{
			if ( type === "time" )
			{
				return function( d ) { return d.timeStamp; };
			}
			else if (type === "ordinal")
			{
				return function( d ) { return d.seriesName; };
			}
			else if ( type === "linear" )
			{
				return function( d ) { return d.value; };
			}
			else if ( type === "sqrt" )
			{
				return function( d ) { return d.value; };
			}
		},


		tickFormatForAxisType: function ( type )
		{
			/*
				declare and create our custom time formatter.
				The array of functions is tested in reverse order,
				the first one to return 'true' is used to do the formatting
			*/
			var customTimeFormat;
			function timeFormat( formats )
			{
				return function( date )
				{
					var i = formats.length - 1,
						f = formats[ i ];
					while ( !f[1]( date ) ) f = formats[ --i ];
					return f[ 0 ]( date );
				};
			}

			customTimeFormat = timeFormat( [
				[ d3.time.format( "%Y" ), function() { return true; }],
				[ d3.time.format( "%b %d" ), function(d) { return d.getMonth() !== 0 || d.getDate() !== 1; }],
				[ d3.time.format( "%a %d" ), function(d) { return d.getDay() && d.getDate() !== 1; }],
				[ d3.time.format( "%I %p" ), function(d) { return d.getHours(); }],
				[ d3.time.format( "%I:%M" ), function(d) { return d.getMinutes(); }],
				[ d3.time.format( ":%S" ), function(d) { return d.getSeconds(); }],
				[ d3.time.format( ".%L" ), function(d) { return d.getMilliseconds(); }]
			] );

			if ( type === "time" )
			{
				return customTimeFormat;
			}
			else if (type === "ordinal")
			{
				return function( d ) { return d; };
			}
			else if ( type === "linear" )
			{
				return this.numberFormatter;
			}
			else return this.numberFormatter;
		},


		// since we are abstracting d3 within theses charts, we cannot pass the time interval directly
		// this function maps a string name to a d3.time interval
		timeIntervalForIntervalName: function ( name )
		{
			var interval;

			switch ( name )
			{
				case 'days':
					interval = d3.time.days;
					break;
				case 'dates':
					interval = d3.time.days;
					break;
				case 'weeks':
					interval = d3.time.weeks;
					break;
				case 'years':
					interval = d3.time.years;
					break;
				case 'months':
					interval = d3.time.months;
					break;
				case 'minutes':
					interval = d3.time.minutes;
					break;
				case 'hours':
					interval = d3.time.hours;
					break;
				default:
					interval = d3.time.days;
					break;
			}

			return interval;
		},


		applyAxisPadding: function()
		{
			var xScale = this.xScale,
				yScale = this.yScale,
				zScale = this.zScale;

			// x axis
			if ( this.xAxis )
			{
				if ( this.axisTypes.x === 'time' ) xScale.domain( this.dateRangeWithPadding( xScale.domain(), this.xPadding ) );  // pad with time
				else if ( this.axisTypes.x !== 'ordinal' ) xScale.domain( this.linearRangeWithPadding( xScale.domain(), this.xPadding ) );  // pad with percent of original value
			}

			// y axis
			if ( this.yAxis )
			{
				if ( this.axisTypes.y === 'time' ) yScale.domain( this.dateRangeWithPadding( yScale.domain(), this.yPadding ) );  // pad with time
				else if ( this.axisTypes.y !== 'ordinal' ) yScale.domain( this.linearRangeWithPadding( yScale.domain(), this.yPadding ) );  // pad with percent of original value
			}

			// z axis
			if ( this.zAxis )
			{
				if ( this.axisTypes.z === 'time' ) zScale.domain( this.dateRangeWithPadding( zScale.domain(), this.zPadding ) );  // pad with time
				else if ( this.axisTypes.z !== 'ordinal' ) zScale.domain( this.linearRangeWithPadding( zScale.domain(), this.zPadding ) );  // pad with percent of original value
			}
		},


		zoomToNewRanges: function( ranges )
		{
			if ( this.xScale )
			{
				this.xScale.domain( [ ranges.xMin || this.xScale.domain()[0], ranges.xMax || this.xScale.domain()[1] ] );
			}
			if ( this.yScale )
			{
				this.yScale.domain( [ ranges.yMin || this.yScale.domain()[0], ranges.yMax || this.yScale.domain()[1] ] );
			}
			if ( this.zScale )
			{
				this.zScale.domain( [ ranges.zMin || this.zScale.domain()[0], ranges.zMax || this.zScale.domain()[1] ] );
			}

			this.redraw();
		},


		currentDataRanges: function()
		{
			var ranges = {};

			if ( this.xScale )
			{
				ranges.xMin = this.xScale.domain()[0];
				ranges.xMax = this.xScale.domain()[1];
			}
			if ( this.yScale )
			{
				ranges.yMin = this.yScale.domain()[0];
				ranges.yMax = this.yScale.domain()[1];
			}
			if ( this.zScale )
			{
				ranges.zMin = this.zScale.domain()[0];
				ranges.zMax = this.zScale.domain()[1];
			}

			return ranges;
		},


		dateRangeWithPadding: function( inputRange, paddingUnits )
		{
			var newMin = new Date( inputRange[ 0 ] ),
				newMax = new Date( inputRange[ 1 ] );

			if ( inputRange[ 0 ].getTime() - inputRange[ 1 ].getTime() === 0 ) paddingUnits = paddingUnits || 1;


				// we have no range for the axis, so find out whether it is a a year, month or day
				if ( inputRange[ 0 ].getDate() !== 1 )
				{
					// add a day either side
					newMin.setDate( newMin.getDate() - paddingUnits );
					newMax.setDate( newMax.getDate() + paddingUnits );
				}
				else
				{
					if ( inputRange[ 0 ].getMonth() !== 0 )
					{
						// add a month either side
						newMin.setMonth( newMin.getMonth() - paddingUnits );
						newMax.setMonth( newMax.getMonth() + paddingUnits );
					}
					else
					{
						// add a year either side
						newMin.setFullYear( newMin.getFullYear() - paddingUnits );
						newMax.setFullYear( newMax.getFullYear() + paddingUnits );
					}

			}

			return [ newMin, newMax ];
		},


		linearRangeWithPadding: function( inputRange, paddingPercent )
		{
			// calculate the difference between the two values
			var difference = inputRange[ 1 ] - inputRange[ 0 ],
				newMin     = difference === 0 ? inputRange[ 0 ] - ( inputRange[ 0 ] * paddingPercent ) : inputRange[ 0 ] - ( difference * paddingPercent ),
				newMax     = difference === 0 ? inputRange[ 1 ] + ( inputRange[ 1 ] * paddingPercent ) : inputRange[ 1 ] + ( difference * paddingPercent );

			// if our original minimum was zero or above, don't let the new minimum go below this
			if ( this.shouldLockAxesToPositive ) if ( inputRange[ 0 ] >= 0 && newMin < 0 ) newMin = 0;

			// return the new min/max
			return [ newMin, newMax ];
		},


		axisShouldHideZeroTicks: function( axis )
		{
			var result = false;

			if ( axis === 'x' )
			{
				if ( this.axisTypes.y !== null && this.axisTypes.y !== 'time' && this.yScale.domain()[0] < 0 && this.yScale.domain()[1] > 0 ) result = true;
			}
			else if ( axis === 'y' )
			{
				if ( this.axisTypes.x !== null && this.axisTypes.x !== 'time' && this.xScale.domain()[0] < 0 && this.xScale.domain()[1] > 0 ) result = true;
			}
			else if ( axis === 'z' )
			{
				if ( this.axisTypes.x !== null && this.axisTypes.x !== 'time' && this.xScale.domain()[0] < 0 && this.xScale.domain()[1] > 0 ) result = true;
			}

			return result;
		},


		removeZeroTicks: function( tickValues )
		{
			var i = 0;
			for ( i = 0; i < tickValues.length; i++ )
			{
				if ( tickValues[i] === 0 )
				{
					tickValues.splice( i, 1 );
					break;
				}
			}

			return tickValues;
		},


		numberFormatter: function( input )
		{
			var precision = 2,
				output = '';

			if ( input < 1 && input > -1 ) output = input.toFixed( precision );
			else if ( Math.abs( input ) >= 1000000000000 ) output = input / 1000000000000 + 'T';
			else if ( Math.abs( input ) >= 1000000000 ) output = input / 1000000000 + 'B';
			else if ( Math.abs( input ) >= 1000000 ) output = input / 1000000 + 'M';
			else if ( Math.abs( input ) >= 1000 ) output = input / 1000 + 'K';
			else output = input.toFixed( precision );

			// catch any rounding errors
			if ( input.toFixed( precision ) === '-0.00' || input.toFixed( precision ) === '0.00' ) output = '0';

			return output;
		},


		numberFormatterForValues: function( values )
		{
			var precision = this.calculateMinimumDecimalPrecision( values ),
			    formatter = function( input )
				{
					var output = '';

					if ( input < 1 && input > -1 ) output = input.toFixed( precision );
					else if ( Math.abs( input ) >= 1000000000000 ) output = input / 1000000000000 + 'T';
					else if ( Math.abs( input ) >= 1000000000 ) output = input / 1000000000 + 'B';
					else if ( Math.abs( input ) >= 1000000 ) output = input / 1000000 + 'M';
					else if ( Math.abs( input ) >= 1000 ) output = input / 1000 + 'K';
					else output = input.toFixed( precision );

					// catch any rounding errors
					if ( input.toFixed( precision ) === '-0.00' || input.toFixed( precision ) === '0.00' ) output = '0';

					return output;
				};
			return formatter;
		},


		calculateMinimumDecimalPrecision: function( values )
		{
			var precision     = 0,
			duplicatesPresent = function( values, precision )
			{
				var valuesFound = {},
					duplicates = false,
					i;
				 for ( i = 0; i < values.length; i++ )
				 {
					if ( valuesFound[ values[ i ].toFixed( precision ) ] === true ) duplicates = true;
					else valuesFound[ values[ i ].toFixed( precision ) ] = true;
				 }

				 return duplicates;
			};

			while ( duplicatesPresent( values, precision ) === true && precision < 20 )
			{
				precision++;
			}

			return precision;
		},


		/*
			indexDataByValue: this function creates a lookup table where we can retrieve all datapoints for a given position on the x Axis
		*/
		indexDataByXValue: function ( data, xAccessor, store )
		{
			var allKeys = [],
			    i       = 0,
			    j       = 0,
			    xVal,
			    d;  // contains all of the references

			// loop through all data
			for ( i = 0; i < data.length; i++ )
			{
				for ( j = 0; j < data[ i ].data.length; j++ )
				{
					d = data[ i ].data[ j ];
					d.seriesName = data[ i ].seriesName;

					// get the x value of this datapoint
					xVal = xAccessor( d );

					// check if there are any previous datapoints which have the same x value ( ie multiple series )
					if ( store[ xVal ] === undefined )
					{
						// nothing stored for this yet, so create new array containing datapoint
						store[ xVal ] = [ d ];
						// also add it to our list of keys
						allKeys.push( xVal );
					}
					else if ( store[ xVal ] instanceof Array )
					{
						// we've seen another datapoint with this same x value, so just add it to the array..
						store[ xVal ].push( d );
					}
					else
					{
						// error!
					}
				}
			}

			// sort the keys ascending
			allKeys.sort( function ( val1, val2 )
			{
			  if ( val1 > val2 ) return 1;
			  if ( val1 < val2 ) return -1;
			  return 0;
			} );

			// attach to the lookup table
			store.allKeys = allKeys;
		},


		findNearestXValue: function( refVal, indexedData )
		{
			var startIndex      = 0,
			    stopIndex       = indexedData.allKeys.length - 1,
			    middleIndex     = Math.floor( ( stopIndex + startIndex ) / 2 ),
			    found           = false,
			    isDate          = refVal instanceof Date ? true : false,
			    result;

			// this function will return true for two different date objects set to the same time
			function isEqual( isDate, a, b )
			{
				if ( isDate ) return a.getTime() === b.getTime();
				else return a === b;
			}

			// given a reference value, find the closest point on the axis where we have a data point

			// first check if we are beyond the bounds of our data
			if ( refVal <= indexedData.allKeys[ 0 ] )
			{
				result = indexedData[ indexedData.allKeys[ 0 ] ];
			}
			else if ( refVal >= indexedData.allKeys[ indexedData.length - 1 ] )
			{
				result = indexedData[ indexedData.allKeys[ indexedData.length - 1 ] ];
			}
			// must be somewhere in between, best get looking!
			else
			{
				while( found === false )
				{
					if ( isEqual( isDate, indexedData.allKeys[ middleIndex ], refVal ) )
					{
						// we've lucked into finding the right value
						result = indexedData[ indexedData.allKeys[ middleIndex ] ];
						found = true;
					}
					else if ( startIndex < stopIndex )
					{
						// keep searching

						// adjust search area
				        if ( refVal < indexedData.allKeys[ middleIndex ] )
				        {
				            stopIndex = middleIndex - 1;
				        }
				        else if ( refVal > indexedData.allKeys[ middleIndex ] )
				        {
				            startIndex = middleIndex + 1;
				        }

				        // recalculate middle
						middleIndex = Math.floor( ( stopIndex + startIndex ) / 2 );
					}
					else
					{
						// indices have converged, we still haven't found an exact match
						found = true;

						if ( refVal < indexedData.allKeys[ middleIndex ] )
				        {
				            // choose between middleIndex and middleIndex - 1
				            if ( !isDate )
							{
								// numbers should be simple
								if ( ( indexedData.allKeys[ middleIndex ] - refVal ) < ( ( refVal ) - indexedData.allKeys[ middleIndex - 1 ] ) )
								{
									// d is closer, choose d
									result = indexedData[ indexedData.allKeys[ middleIndex ] ];
								}
								else
								{
									// d - 1 is closer, choose that instead
									result = indexedData[ indexedData.allKeys[ middleIndex - 1 ] ];
								}
							}
							else
							{
								// looks like we probably have a date
								if ( ( indexedData.allKeys[ middleIndex ].getTime() - refVal.getTime() ) < ( refVal.getTime() - indexedData.allKeys[ middleIndex - 1 ].getTime() ) )
								{
									// d is closer, choose d
									result = indexedData[ indexedData.allKeys[ middleIndex ] ];
								}
								else
								{
									// d - 1 is closer, choose that instead
									result = indexedData[ indexedData.allKeys[ middleIndex - 1 ] ];
								}
							}
				        }
				        else if ( refVal > indexedData.allKeys[ middleIndex ] )
				        {
				            // choose between middleIndex and middleIndex + 1
				            if ( !isDate )
							{
								// numbers should be simple
								if ( ( indexedData.allKeys[ middleIndex ] - refVal ) < ( ( refVal ) - indexedData.allKeys[ middleIndex + 1 ] ) )
								{
									// d is closer, choose d
									result = indexedData[ indexedData.allKeys[ middleIndex ] ];
								}
								else
								{
									// d - 1 is closer, choose that instead
									result = indexedData[ indexedData.allKeys[ middleIndex + 1 ] ];
								}
							}
							else
							{
								// looks like we probably have a date
								if ( ( indexedData.allKeys[ middleIndex ].getTime() - refVal.getTime() ) > ( refVal.getTime() - indexedData.allKeys[ middleIndex + 1 ].getTime() ) )
								{
									// d is closer, choose d
									result = indexedData[ indexedData.allKeys[ middleIndex ] ];
								}
								else
								{
									// d - 1 is closer, choose that instead
									result = indexedData[ indexedData.allKeys[ middleIndex + 1 ] ];
								}
							}
						}
					}
			    }
			}
			return result || [ { } ];
		},


		shadeColour: function ( color, percent )
		{
			var num = parseInt( color.slice( 1 ), 16 ), amt = Math.round( 2.55 * percent ), R = ( num >> 16 ) + amt, B = ( num >> 8 & 0x00FF ) + amt, G = ( num & 0x0000FF ) + amt;
			return "#" + ( 0x1000000 + ( R<255?R<1?0:R:255 )*0x10000 + ( B<255?B<1?0:B:255 ) * 0x100 + ( G<255?G<1?0:G:255 ) ).toString( 16 ).slice( 1 );
		},


		/* Math functions */

		findLineOfBestFit: function( xValues, yValues, xInput )
		{
			var count = xValues.length, // could as easily be y, just the total number of datapoints...
				sumX  = 0,
				sumX2 = 0,
				sumY  = 0,
				sumXY = 0,
				xMean,
				yMean,
				slope,
				yInt,
				yOutput;

			xValues.forEach( function( dp )
			{  // sum total of all the x values
				sumX += dp;
			} );

			yValues.forEach( function( dp )
			{	// sum total of all the y values
				sumY += dp;
			});

			xValues.forEach( function( dp )
			{	// sum of all the squared x values
				sumX2 += dp * dp;
			} );

			xValues.forEach( function( dp, i )
			{   // sum of all the products of x and y
				sumXY += dp * yValues[ i ];
			} );

			xMean = sumX / count;

			yMean = sumY / count;

			slope = ( sumXY - sumX * yMean ) / ( sumX2 - sumX * xMean );

			yInt = yMean - slope * xMean;

			yOutput = slope * xInput + yInt;

			return yOutput;
		},


		findPointOnCircleWithRadiusAtAngle: function( radius, angle )
		{
			var x = radius * Math.cos( angle ),
				y = radius * Math.sin( angle );

			return [ x, y ];
		},


		degreesFromRadians: function( radians )
		{
			return radians * 180 / Math.PI;
		},


		radiansFromDegrees: function( degrees )
		{
			return degrees * Math.PI / 180;
		},


		boundsForLabelWithDatumAndRadius: function( label, d, endRadius )
		{
			var middleAngle = this.degreesFromRadians( d.startAngle ) + ( (this.degreesFromRadians( d.endAngle ) - this.degreesFromRadians( d.startAngle ) ) / 2 ) - 90,
				pos = this.findPointOnCircleWithRadiusAtAngle( endRadius, this.radiansFromDegrees( middleAngle ) ),
				bBox = label.getBBox();

			return { x:pos[0] + bBox.x, y:pos[1] + bBox.y, width:bBox.width, height:bBox.height };
		},

		boundsCollide: function( a, b )
		{
			var result = true;

			if ( ( a.y + a.height ) < b.y ) result = false;
			else if ( a.y > ( b.y + b.height ) ) result = false;
			else if ( a.x > ( b.x + b.width ) ) result = false;
			else if ( ( a.x + a.width ) < b.x ) result = false;

			return result;
		}
	};


	return WashCostAreaChart;
})();