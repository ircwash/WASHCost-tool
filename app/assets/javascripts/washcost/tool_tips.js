$(document).ready(function () {

  'use strict';

  var html = '<div class="info_tab">';
  html += '<div class="info_tab--icon"></div>';
  html += '<div class="info_tab--container">';
  html += '<div class="info_tab--content">';
  html += '<p class="info_tab--content--text"></p>';
  html += '<p>{0}</p>';
  html += '</div>';
  html += '</div>';
  html += '</div>';

  function init () {

    $('*[data-tooltip]').each(function () {
      var txt = $(this).attr('data-tooltip');
      $(this).append('<span class="tooltip"></span>');
      $(this).append(html.replace('{0}', txt));
    });

    $('*[data-tooltip]').on('click', '.info_tab', function () {
      $(this).css({ 'display': 'none' });
      return false;
    });

    $('*[data-tooltip]').on('click', '.tooltip', function () {
      $('.info_tab').css({ 'display': 'none' });
      var tab = $(this).parent().find('.info_tab');
      if (tab) tab.css({ 'display': 'block' });
      return false;
    });

  }

  init();

});