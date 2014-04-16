$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $('.chzn-select').chosen( { allow_single_deselect:true } );

    $('select[name="advanced_water_questionnaire[currency]"],select[name="advanced_sanitation_questionnaire[currency]"]').on('change', function (event) {
      var currency = $(this).val().toUpperCase();
      $('[data-currency]').each(function () {
        var n = $(this).attr('data-currency');
        if (currency === null || currency === '') currency = 'USD';
        $(this).attr('placeholder', n + ' (' + currency + ')');
      });
    });

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