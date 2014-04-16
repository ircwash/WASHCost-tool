$( document ).ready( function()
{
  'use strict';

  function init()
  {
    $( '[data-column_dependency]' ).on( 'keyup', set_dependencies ).each( set_dependencies );
    $( '[data-column_dependency]' ).on( 'change', set_dependencies ).each( set_dependencies );
    $('[name="advanced_water_questionnaire[service_level_share][]"]').on('keyup', enforce_numeric);
    $('[name="advanced_water_questionnaire[service_level_share][]"]').on('blur', add_percentage);
    $('[data-numeric]').on('keyup', enforce_numeric);
    $('[data-numeric]').on('change', enforce_numeric);
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

  function set_dependencies()
  {
    var associated = $( this ).data( 'column_dependency' ), dependents = $( '[data-column_dependency-dependent="' + associated + '"]' );
 
    if ( this.value === '' )
    {
      dependents.find( 'input:not([type="checkbox"],[type="radio"])' ).val( '' ).attr( { disabled:'disabled' } );
      dependents.find( 'input[type="checkbox"],[type="radio"]' ).removeAttr( 'checked' ).attr( { disabled:'disabled' } );
      dependents.find( 'select' ).each( function(){ this.selectedIndex = 0; } );
      dependents.find( 'select' ).attr( { disabled:'disabled' } ).trigger( 'chosen:updated' );
    }
    else
    {
      dependents.find( 'input' ).removeAttr( 'disabled' );
      dependents.find( 'select' ).removeAttr( 'disabled' ).trigger( 'chosen:updated' );
      $('select[name="advanced_water_questionnaire[surface_water_primary_source][]"]').attr( { disabled:'disabled' } ).trigger( 'chosen:updated' );
    }
  }

  init();
} );

