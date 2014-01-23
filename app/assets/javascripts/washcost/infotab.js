$( document ).ready( function()
{
  'use strict';

  var _info_tab = $('.info_tab');


  function init()
  {
    var width = 0;

    if ( _info_tab.length > 0 )
    {
      _info_tab.on( 'click', '.info_tab--icon', function( event )
      {
        // animate tab
        _info_tab.toggleClass( 'info_tab-open' );
      } );
    }
  }


  init();
} );

