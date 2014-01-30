$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '[data-dynamic_form]' ).on( 'ajax_submit', function( event, result )
    {
      // update the progress footer
      $( '[data-progress-label]' ).text( '(' + result.progress + '%)' );
      $( '[data-progress-bar]' ).css( { width:result.progress + '%' } );
    } );
  }


  init();
} );

