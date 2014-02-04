$( document ).ready( function()
{
  'use strict';

  var colours = [ '#1f9cd8', '#e40e7e' ];

  $( '[data-minichart]' ).each( function(i)
  {
    var $el        = $( this ),
        size       = $el.width(),
        radius     = size / 2,
        depth      = size / 8,
        percentage = parseInt( $el.data( 'minichart-percentage' ), 10 ) / 100,
        canvas     = $( '<canvas width="' + size + '" height="' + size + '"></canvas>' )[0],
        context;

    // initialise canvas
    context = canvas.getContext( '2d' );
    context.fillStyle = '#d7d7d7';

    // draw empty ring
    drawDoughnut( context, radius, size, depth, 0, 1 );

    // draw segment
    context.fillStyle = colours[ i % 2 ];
    drawDoughnut( context, radius, size, depth, 0, percentage );

    // add chart to dom
    $el.append( canvas );
  } );


  function drawDoughnut( context, r, w, d, start, amount )
  {
    var s = -0.5 * Math.PI + start * 2 * Math.PI,
        e = s + amount * 2 * Math.PI;

    context.beginPath();
    context.arc( r, r, r, s, e, false );
    context.lineTo( r + ( r - d ) * Math.cos( e ), r + ( r - d ) * Math.sin( e ) );
    context.arc( r, r, r - d, e, s, true );
    context.lineTo( r + ( r - d ) * Math.cos( s ), r + ( r - d ) * Math.sin( s ) );
    context.closePath();

    context.fill();
  }
} );