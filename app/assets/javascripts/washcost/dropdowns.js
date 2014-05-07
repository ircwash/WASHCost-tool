$( document ).ready( function()
{
  'use strict';

  function updateWaterSource (idx, el) {
    console.log(idx)
    var id = el.attr('id').replace('water_source', 'surface_water_primary_source');
    var $item = $('#' + id);
    if (idx != 2) {
      $item.prop('selectedIndex', 0);
      $item.attr( { disabled:'disabled' } ).trigger( 'chosen:updated' );
    } else {
      $item.removeAttr( 'disabled' ).trigger( 'chosen:updated' );
    }
  }

  function init() {

    $('.chzn-select').chosen( { allow_single_deselect:true, width: "100%" } );

    $('select[name="advanced_water_questionnaire[currency]"],select[name="advanced_sanitation_questionnaire[currency]"]').on('change', function (event) {
      var currency = $(this).val().toUpperCase();
      $('[data-currency]').each(function () {
        var n = $(this).attr('data-currency');
        if (currency === null || currency === '') currency = 'USD';
        $(this).attr('placeholder', n + ' (' + currency + ')');

        // Handles inputs already populated
        if ($(this).val()) {
          var re = / \(([^}]+)\)/g
          var value = $(this).val().replace(re, '');
          $(this).val(value + ' (' + currency + ')');
        }

      });
    });

    // Handle surface water
    $('select[name="advanced_water_questionnaire[water_source][]"]').each(function (e) {
      updateWaterSource(this.selectedIndex, $(this));
    });

    $('select[name="advanced_water_questionnaire[water_source][]"]').on('change', function( event ) {
      updateWaterSource(this.selectedIndex, $(this));
    });

  }

  init();
} );