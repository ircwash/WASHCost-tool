$( document ).ready( function()
{
  'use strict';


  function init()
  {
    $( '[data-column_dependency]' ).on( 'change', set_dependencies ).each( set_dependencies );
  }


  function set_dependencies()
  {
    var associated = $( this ).data( 'column_dependency' ),
        dependents = $( '[data-column_dependency-dependent="' + associated + '"]' );

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
    }
  }


  init();
} );

