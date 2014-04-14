$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '[data-dynamic_form]' ).find( 'input[name],select[name]' ).on( 'change', function()
    {
      var form = $( this ).parents( '[data-dynamic_form]' ),
          url  = form.data( 'dynamic_form' );

      // Forces a selection (default = Don't know) for any enabled selects that have not been set on submit
      if ($('form#new_advanced_water_questionnaire').length > 0) {
        $('form#new_advanced_water_questionnaire').find( 'select:enabled' ).each( function () { 
          if (this.selectedIndex === 0)
            this.selectedIndex = this.length-1;
        });
      }

      form.ajaxSubmit( { url:url, success:function( result ) {
        // trigger notification
        form.trigger( 'ajax_submit', result );
      } } );
    } );
  }


  init();
} );

