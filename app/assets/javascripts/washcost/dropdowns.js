$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $('.chzn-select').chosen( { allow_single_deselect:true } );

    // Handle surface water
    $('select[name="advanced_water_questionnaire[water_source][]"]').on('change', function( event ) {
      var idx = this.selectedIndex;
      var id = $(this).attr('id').replace('water_source', 'surface_water_primary_source');
      var $item = $('#' + id);
   
      if (idx != 2) {
        $item.attr( { disabled:'disabled' } ).trigger( 'chosen:updated' );
      } else {
        $item.removeAttr( 'disabled' ).trigger( 'chosen:updated' );
      }
    });

  }


  init();
} );