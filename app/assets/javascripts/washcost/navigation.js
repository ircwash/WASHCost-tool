$( document ).ready( function()
{
  'use strict';

  var _navigation  = $( '.navigation--subcategory' ),
      _list        = _navigation.find( 'ul' ),
      _items       = _navigation.find( 'li' ),
      _active_item = _items.find( '.navigation--subcategory--link-active' ).parent(),
      _active_index;


  function init()
  {
    if ( _navigation.length && $( window ).width() > 600 )
    {
      // set full width of navigation items
      _list.css( { width:_items.width() * _items.length } );

      // offset navigation according to selected item
      _active_index = _items.index( _active_item );
      _navigation[0].scrollLeft = _active_index * _items.width() - _navigation.width() / 2;
    }
  }


  init();
} );
