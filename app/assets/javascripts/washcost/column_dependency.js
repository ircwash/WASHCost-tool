$( document ).ready( function()
{
  'use strict';

  function init() {
    $('[data-column_dependency]').on( 'keyup', set_dependencies ).each( set_dependencies );
    $('[data-column_dependency]').on( 'change', set_dependencies ).each( set_dependencies );
    $('[data-percentage]').on('keyup', enforce_numeric);
    $('[data-percentage]').on('blur', add_percentage);
    $('[data-numeric]').on('keyup', enforce_numeric);
    $('[data-currency]').on('blur', add_currency);
    $('[data-currency]').on('focus', enforce_numeric);
    $('[data-percentage]').on('focus', enforce_numeric);

    $('input#advanced_sanitation_questionnaire_region_unknown').on('change', function () {
      if (this.checked) {
        $('input#advanced_sanitation_questionnaire_region').val('').attr( { disabled:'disabled' } );
      }else{
        $('input#advanced_sanitation_questionnaire_region').removeAttr( 'disabled' );
      }
    });

    $('input#advanced_sanitation_questionnaire_town_unknown').on('change', function () {
      if (this.checked) {
        $('input#advanced_sanitation_questionnaire_town').val('').attr( { disabled:'disabled' } );
      }else{
        $('input#advanced_sanitation_questionnaire_town').removeAttr( 'disabled' );
      }
    });

    // Handle on load and inputs already populated
    $('[data-dynamic_form]').find('[data-currency]').each(function() {
      var re = / \(([^}]+)\)/g
      var value = $(this).val().replace(re, '');
      var currency = re.exec($(this).attr('placeholder'))[0];
      if (value === '' || value === null) return;
      $(this).val(value + currency);
    });

    // Handle on load and inputs already populated
    $('[data-dynamic_form]').find('[data-percentage]').each(function() {
      var value = $(this).val().replace(/%/g, '');
      if (value === '' || value === null) return;
      $(this).val(value + '%');
    });
  }
  
  function enforce_numeric() {
    var value = $(this).val();
    $(this).val(value.replace(/[^0-9\.]+/g, ''));
  }

  function add_percentage() {
    var value = $(this).val().replace(/%/g, '');
    if (value === '' || value === null) value = 0;
    $(this).val(value + '%');
  }

  function add_currency() {
    var re = / \(([^}]+)\)/g
    var value = $(this).val().replace(re, '');
    var currency = re.exec($(this).attr('placeholder'))[0];
    if (value === '' || value === null) return;
    $(this).val(value + currency);
  }

  function set_dependencies() {
    var associated = $( this ).data( 'column_dependency' ), dependents = $( '[data-column_dependency-dependent="' + associated + '"]' );
    if ( this.value === '' ) {
      dependents.find( 'input:not([type="checkbox"],[type="radio"])' ).val( '' ).attr( { disabled:'disabled' } );
      dependents.find( 'input[type="checkbox"],[type="radio"]' ).removeAttr( 'checked' ).attr( { disabled:'disabled' } );
      dependents.find( 'select' ).each( function(){ this.selectedIndex = 0; } );
      dependents.find( 'select' ).attr( { disabled:'disabled' } ).trigger( 'chosen:updated' );
    } else {
      dependents.find( 'input' ).removeAttr( 'disabled' );
      dependents.find( 'select' ).removeAttr( 'disabled' ).trigger( 'chosen:updated' );
      
      // Handles the water surface selection when a parent column change
      var id = $(this).attr('id').replace('supply_system_technologies', 'surface_water_primary_source');
      if (id.match('surface_water_primary_source')) {
        var $item = $('#' + id);
        $item.attr( { disabled:'disabled' } ).trigger( 'chosen:updated' );
      }
    }
  }

  init();
});