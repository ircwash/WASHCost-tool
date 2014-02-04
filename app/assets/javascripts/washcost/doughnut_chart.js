$( document ).ready( function()
{
  'use strict';

  var colours = [ '#1f9cd8', '#e40e7e' ];

  $( '[data-minicharts]' ).each( function()
  {
    var start   = 0,
        segment = 0;

    $( '[data-minichart]' ).each( function()
    {
      var $el        = $( this ),
          size       = $el.width(),
          radius     = size / 2,
          depth      = size / 4,
          percentage = parseInt( $el.data( 'minichart-percentage' ), 10 ) / 100,
          canvas     = $( '<canvas width="' + size + '" height="' + size + '"></canvas>' )[0],
          context;

      // initialise canvas
      context = canvas.getContext( '2d' );
      context.fillStyle = '#d7d7d7';

      // draw empty ring
      drawDoughnut( context, radius, size, depth, 0, 1 );

      // draw segment
      context.fillStyle = colours[ segment ];
      drawDoughnut( context, radius, size, depth, start, percentage );

      // add chart to dom
      $el.append( canvas );

      // increment start position
      start   += percentage;
      segment += 1;
    } );
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