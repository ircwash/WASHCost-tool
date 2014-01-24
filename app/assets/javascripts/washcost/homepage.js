$( document ).ready( function()
{
  'use strict';

  var _info_tab = $('.info_tab');


  function init()
  {
    // bind events
    $( '.homage--video--placeholder' ).on( 'click', function()
    {
      $( this ).replaceWith( '<iframe src="https://player.vimeo.com/video/73270180?autoplay=true" width="800" height="451" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>' );
    } );
  }


  init();
} );

