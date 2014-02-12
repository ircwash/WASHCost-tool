$( document ).ready( function()
{
  'use strict';

  var _info_tab = $('.info_tab');


  function init()
  {
    var width = 0;

    if ( _info_tab.length > 0 )
    {
      setWidth();

      _info_tab.on( 'click', '.info_tab--icon', function( event )
      {
        // animate tab
        _info_tab.toggleClass( 'info_tab-open' );

        setWidth();
      } );
    }
  }


  function setWidth()
  {
    _info_tab.find( '.info_tab--container' ).css( { width:$( window ).width() >= 600 ? -30 + 2 * _info_tab.parent().width() / 3 : _info_tab.parent().width() } );
  }

  init();
} );

