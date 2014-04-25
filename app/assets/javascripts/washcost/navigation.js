$(document).ready(function() {
  'use strict';

  var _navigation = $('.navigation--subcategory'),
    _list = _navigation.find('ul'),
    _items = _navigation.find('li'),
    _active_item = _items.find('.navigation--subcategory--link-active').parent(),
    _active_index;

  function sizeNav() {

    if (_navigation.length && $(window).width() > 800) {

      _list.css({
        width: _items.width() * _items.length
      });

      _active_index = _items.index(_active_item);
      _navigation[0].scrollLeft = _active_index * _items.width() - _navigation.width() / 2;

    } else if (_navigation.length) {

      _list.css({
        width: '100%'
      });

    }

  }

  function init() {

    sizeNav();

    $(window).resize(function () {

      sizeNav();

    });

  }

  $('.report-delete').on('click', function() {
    return confirm('Are you sure?');
  });

  init();
  
});