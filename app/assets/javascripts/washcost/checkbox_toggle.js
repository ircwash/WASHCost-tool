$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '[data-checkbox_toggle-field]' ).on( 'keydown', function( event )
    {
      $('.dual_column_form--field--styled_checkbox').on('keyup', function (e) {
        var code = e.keyCode || e.which;
        if (code === 13) $(this).parent().prev().trigger('click');
      });
    } );

    $( '[data-checkbox_toggle-checkbox]' ).on( 'change', function( event )
    {
      var associated = $( this ).data( 'checkbox_toggle-checkbox' );

      $( '[data-checkbox_toggle-field="' + associated + '"]' ).val( '' );
    } );
  }


  init();
} );

