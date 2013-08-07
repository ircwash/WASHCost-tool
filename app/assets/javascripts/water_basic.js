$(document).ready(function(){
    // Option buttons that are checked should be highlighted.
    $( "[checked='checked']" ).parent().addClass('ticked');

    // Page 3
    if( document.getElementById('populationSlider')){

        //default
        $('input[name="population"]').val(0);

        $( "#populationSlider" ).slider({
            min: LOG_SLIDER.gMinPrice,
            max: LOG_SLIDER.gMaxPrice,
            change: function( event, ui ) {
                var value = Math.round(Number(LOG_SLIDER.expon(ui.value)/100)) * 100;
                $('input[name="population"]').val(value);
                var stringVal = '';
                stringValue= value.toLocaleString();
                $('#populationValue').html(stringValue);
            },
        });

        var slider_value = Number(document.getElementById('populationSlider').getAttribute("data-slider_value"));
        $( "#populationSlider" ).slider({value: LOG_SLIDER.logposition(slider_value)} );
    }

    // Page 4
    if( document.getElementById('capitalSlider')){

        //default
        $('input[name="capital"]').val(0);

        $( "#capitalSlider" ).slider({
            min: 0,
            max: 1000,
            change: function( event, ui ) {
                $('input[name="capital"]').val(ui.value);
                $('#capitalValue').html(ui.value);
            }
        });

        var slider_value = document.getElementById('capitalSlider').getAttribute("data-slider_value");
        $( "#capitalSlider" ).slider({value: slider_value});
    }

    // Page 5
    if( document.getElementById('recurrentSlider')){

        //default
        $('input[name="recurrent"]').val(3);

        $( "#recurrentSlider" ).slider({
            min: 0,
            max: 20,
            change: function( event, ui ) {
                $('input[name="recurrent"]').val(ui.value);
                $('#recurrentValue').html(ui.value);
            }
        });

        var slider_value = document.getElementById('recurrentSlider').getAttribute("data-slider_value");
        $( "#recurrentSlider" ).slider({value: slider_value});
    }

    // Page 6 (Time & Distance)
    if( document.getElementById('timeSlider')){

        //default
        $('input[name="time"]').val(0);

        $( "#timeSlider" ).slider({
            min: 0,
            max: 3,
            step: 1,
            change: function( event, ui ) {
                $('input[name="time"]').val(ui.value);
                $('#timeValue').html(I18n["en"]["form"]["water_basic"]["time"]['answers']['a'+ui.value]);
            }
        });
    }

    // Page 7
    if( document.getElementById('quantitySlider')){

        //default
        $('input[name="quantity"]').val(0);

        $( "#quantitySlider" ).slider({
            min: 0,
            max: 3,
            step: 1,
            change: function( event, ui ) {
                $('input[name="quantity"]').val(ui.value);
                $('#quantityValue').html(db.quantity[ui.value].label);
            }
        });
    }

});
