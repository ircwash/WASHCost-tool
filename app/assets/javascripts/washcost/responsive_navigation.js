$( document ).ready( function()
{
  'use strict';

  var header_button;


  function init()
  {
    header_button = $( '.header--mobile_navigation_button' );

    header_button.on( 'touchend click', toggleNavigation );
  }


  function toggleNavigation( event )
  {
    header_button.toggleClass( 'header--mobile_navigation_button-open' );

    if ( header_button.hasClass( 'header--mobile_navigation_button-open' ) ) $( 'header' ).siblings().on( 'touchstart', toggleNavigation );
    else $( 'header' ).siblings().off( 'touchstart', toggleNavigation );
  }


  init();
} );

