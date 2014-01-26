$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '[data-togglecontent]' ).each( function()
    {
      var link    = $( this ).find( '[data-togglecontent-link]' ),
          content = $( this ).find( '[data-togglecontent-content]' );

      link.on( 'click', function( event )
      {
        event.preventDefault();

        // animate tab
        content.toggleClass( content.data( 'togglecontent-content' ) );
      } );
    } );
  }


  init();
} );

