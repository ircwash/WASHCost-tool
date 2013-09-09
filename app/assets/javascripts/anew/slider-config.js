$(document).ready(function(){

    //---> Basic tool sliders

    // Water Slider
    populationSlider = $('#populationSlider');
    if( populationSlider.length > 0){
        console.log('hey hey!');
        //default
        $('input[name="population"]').val(0);
        slider_display = function( event, ui ) {
            var value = Math.round(Number(LOG_SLIDER.expon(ui.value)/100)) * 100;
            $('input[name="population"]').val(value);
            stringValue= value.toLocaleString();
            $('#populationValue').html(stringValue);
        };
        populationSlider.slider({
            min: LOG_SLIDER.gMinPrice,
            max: LOG_SLIDER.gMaxPrice,
            change: slider_display,
            slide: slider_display
        });
        var slider_value = Number(populationSlider.attr('data-slider_value'));
        populationSlider.slider({value: LOG_SLIDER.logposition(slider_value)});
    }

});
