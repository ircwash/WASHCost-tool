$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '[data-dynamic_form]' ).find( 'input[name],select[name]' ).on( 'change', function()
    {
      var form = $( this ).parents( '[data-dynamic_form]' ),
          url  = form.data( 'dynamic_form' );

      form.ajaxSubmit( { url:url, success:function( result )
      {
        // trigger notification
        form.trigger( 'ajax_submit', result );
      } } );
    } );
  }


  init();
} );

