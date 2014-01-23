$( document ).ready( function()
{
  'use strict';

  var _slider = $( '.slider--widget' ),
      _logslider;

  function init()
  {
    _slider.each( function()
    {
      var slider = $( this ),
          label  = slider.siblings( '.slider--value' ),
          input  = slider.siblings( 'input' ),
          value  = input.val();

      // initialise slider widget
      slider.slider(
      {
        min:_logslider.gMinPrice,
        max:_logslider.gMaxPrice,
        change:slider_display,
        slide:slider_display,
      } );

      // force update of value
      slider.slider( { value:_logslider.logposition( value ) } );
    } );
  }


  function slider_display( event, ui )
  {
    var slider = $( this ),
        label  = slider.siblings( '.slider--value' ),
        input  = slider.siblings( 'input' ),
        value  = Math.round( Number( _logslider.expon( ui.value ) / 100 ) ) * 100;

    // update values
    label.text( value.toLocaleString() );
    input.val( value );
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