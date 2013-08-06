$(document).ready(function(){

    // Page 2
    if( document.getElementById('householdSlider')){

        //default
        $('input[name="household"]').val(0);

        $( "#householdSlider" ).slider({
            step: 1,
            min: 1,
            max: 20,
            change: function( event, ui ) {
                $('input[name="household"]').val(ui.value);
                $('#householdValue').html(ui.value);
            }
        });

        var slider_value = document.getElementById('householdSlider').getAttribute("data-slider_value")
        $( "#householdSlider" ).slider( {value: slider_value})
    }

    // Page 3

    // Page 4
    if( document.getElementById('populationSlider')){


        //default
        $('input[name="capital"]').val(0);

        $( "#populationSlider" ).slider({
            min: 500,
            max: 15000,
            step: 500,
            change: function( event, ui ) {
                $('input[name="population"]').val(ui.value);

                var stringVal= '';

                stringValue= ui.value.toLocaleString();

                $('#populationValue').html(stringValue);
            }
        });
    }


    // Page 4
    if( document.getElementById('capitalSlider')){


        //default
        $('input[name="capital"]').val(0);

        $( "#capitalSlider" ).slider({
            min: 0,
            max: 310,
            change: function( event, ui ) {
                $('input[name="capital"]').val(ui.value);
                $('#capitalValue').html(ui.value);
            }
        });
    }

    // Page 5
    if( document.getElementById('recurrentSlider')){
        //default
        $('input[name="recurrent"]').val(0);

        $( "#recurrentSlider" ).slider({
            min: 3,
            max: 15,
            change: function( event, ui ) {
                $('input[name="recurrent"]').val(ui.value);
                $('#recurrentValue').html(ui.value);
            }
        });
    }

    // Page 6


    // Page 7


    // Page 8


    // Page 9


    // Page 10


});
