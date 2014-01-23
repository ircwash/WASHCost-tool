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
          logarithmic = label.data( 'logarithmic' ),
          value       = logarithmic ? _logslider.logposition( parseInt( label.val(), 10 ) ) : parseInt( label.val(), 10 );

      // initialise slider widget
      slider.slider(
      {
        min:_logslider.gMinPrice,
        max:_logslider.gMaxPrice,
        slide:update_value,
        value:value
      } );

      // force label value to locale string
      label.val( parseInt( label.val() ).toLocaleString() );

      // bind events
      label.on( 'keydown', validate_slider );
      label.on( 'keyup', update_slider );
      label.on( 'focus', unformat_label );
      label.on( 'blur',  reformat_label );
    } );
  }


  function update_value( event, ui )
  {
    var slider = $( this ),
        label  = slider.siblings( '.slider--value' ),
        input  = slider.siblings( '[data-slider-input]' ),
        value  = Math.round( Number( _logslider.expon( ui.value ) / 100 ) ) * 100;

    // update values
    label.val( value.toLocaleString() );
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
        logarithmic = label.data( 'logarithmic' ),
        value       = logarithmic ? _logslider.logposition( parseInt( label.val(), 10 ) ) : parseInt( label.val(), 10 );

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
    gMinPrice:100,
    gMaxPrice:1000000,

    expon:function( val )
    {
      var minv  = Math.log( this.gMinPrice ),
          maxv  = Math.log( this.gMaxPrice ),
          scale = ( maxv - minv ) / ( this.gMaxPrice - this.gMinPrice );

      return Math.exp( minv + scale * ( val - this.gMinPrice ) );
    },

    logposition:function( val )
    {
      var minv  = Math.log( this.gMinPrice ),
          maxv  = Math.log( this.gMaxPrice ),
          scale = ( maxv - minv ) / ( this.gMaxPrice - this.gMinPrice );

      return ( Math.log( val ) - minv ) / scale + this.gMinPrice;
    }
  };


  init();
} );