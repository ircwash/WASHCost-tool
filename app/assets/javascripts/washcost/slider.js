$( document ).ready( function()
{
  'use strict';

  var _slider = $( '.slider--widget' ),
      _logslider;

  function init()
  {
    _slider.each( function()
    {
      var slider      = $( this ),
          label       = slider.siblings( '.slider--value' ),
          input       = slider.siblings( '[data-slider-input]' ),
          below_label = slider.parent().find( '.slider--scale--point-min' ),
          above_label = slider.parent().find( '.slider--scale--point-max' ),
          logarithmic = input.data( 'logarithmic' ),
          min         = input.data( 'slider-min' ),
          max         = input.data( 'slider-max' ),
          values      = input.data( 'slider-values' ),
          below       = input.data( 'slider-below' ),
          above       = input.data( 'slider-above' ),
          value       = logarithmic ? _logslider.logposition( parseInt( label.val(), 10 ), min, max ) : parseInt( label.val(), 10 ),
          options     = { slide:update_value, value:value },
          step_slider, below_offset, above_offset;

      // set up options
      if ( min )  options.min  = min;
      if ( max )  options.max  = max;

      // initialise slider widget
      slider.slider( options );

      // force label value to locale string
      label.val( values ? values[ parseInt( label.val(), 10 ) ] : parseInt( label.val(), 10 ).toLocaleString() );

      // if there are above/below options specified, render this in the ui
      if ( above && below )
      {
        step_slider = slider.width() / ( parseInt( max, 10 ) - parseInt( min, 10 ) );
        below_offset = below * step_slider;
        above_offset = above * step_slider;

        below_label.css( { left:below_offset - below_label.width() / 2 } );
        above_label.css( { left:above_offset - below_label.width() - above_label.width() / 2 } );

        slider.css( 'backgroundPosition', above_offset + 'px 1px, ' + below_offset + 'px 0px, 1px 0px' );
      }

      // bind events
      label.on( 'keydown', validate_slider );
      label.on( 'keyup',   update_slider );
      label.on( 'focus',   unformat_label );
      label.on( 'blur',    reformat_label );
    } );
  }


  function update_value( event, ui )
  {
    var slider      = $( this ),
        label       = slider.siblings( '.slider--value' ),
        input       = slider.siblings( '[data-slider-input]' ),
        logarithmic = input.data( 'logarithmic' ),
        min         = input.data( 'slider-min' ),
        max         = input.data( 'slider-max' ),
        values      = input.data( 'slider-values' ),
        value       = logarithmic ? Math.round( Number( _logslider.expon( ui.value, min, max ) / 100 ) ) * 100 : ui.value;

    // update values
    label.val( values ? values[ value ] : value.toLocaleString() );
    input.val( value );
  }


  function validate_slider( event )
  {
    if ( !( ( event.keyCode >= 48 && event.keyCode <= 57 ) || ( event.keyCode >= 96 && event.keyCode <= 105 ) || ( event.keyCode >= 37 && event.keyCode <= 40 ) || event.keyCode === 13 || event.keyCode === 8 || event.keyCode === 46 || event.keyCode === 9 || event.metaKey ) )
    {
      event.preventDefault();
    }
  }


  function update_slider( event )
  {
    var label       = $( this ),
        input       = label.siblings( '[data-slider-input]' ),
        slider      = label.siblings( '.slider--widget' ),
        logarithmic = input.data( 'logarithmic' ),
        min         = input.data( 'slider-min' ),
        max         = input.data( 'slider-max' ),
        value       = logarithmic ? _logslider.logposition( parseInt( label.val(), 10 ), min, max ) : parseInt( label.val(), 10 );

    // update input
    input.val( value );

    // update slider
    slider.slider( { value:value } );
  }

  function unformat_label( event )
  {
    var label = $( this );

    label.val( label.val().replace( ',', '' ) );
  }


  function reformat_label( event )
  {
    var label = $( this );

    label.val( parseInt( label.val(), 10 ).toLocaleString() );
  }


  // logarithmic slider helper
  _logslider =
  {
    expon:function( val, min, max )
    {
      var minv  = Math.log( min ),
          maxv  = Math.log(max ),
          scale = ( maxv - minv ) / (max - min );

      return Math.exp( minv + scale * ( val - min ) );
    },

    logposition:function( val, min, max )
    {
      var minv  = Math.log( min ),
          maxv  = Math.log(max ),
          scale = ( maxv - minv ) / (max - min );

      return ( Math.log( val ) - minv ) / scale + min;
    }
  };


  init();
} );