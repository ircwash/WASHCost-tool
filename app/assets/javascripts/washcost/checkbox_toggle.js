$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '[data-checkbox_toggle-field]' ).on( 'keydown', function( event )
    {
      var associated = $( this ).data( 'checkbox_toggle-field' );

      $( '[data-checkbox_toggle-checkbox="' + associated + '"]' ).removeAttr( 'checked' );
    } );

    $( '[data-checkbox_toggle-checkbox]' ).on( 'change', function( event )
    {
      var associated = $( this ).data( 'checkbox_toggle-checkbox' );

      $( '[data-checkbox_toggle-field="' + associated + '"]' ).val( '' );
    } );
  }


  init();
} );

