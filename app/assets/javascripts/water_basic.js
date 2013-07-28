$(document).ready(function(){

    // Page 3
    if( document.getElementById('populationSlider')){

        //default
        $('input[name="population"]').val(0);

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
        $('input[name="capital"]').val(30);

        $( "#capitalSlider" ).slider({
            min: 30,
            max: 131,
            change: function( event, ui ) {
                $('input[name="capital"]').val(ui.value);
                $('#capitalValue').html(ui.value);
            }
        });
    }

    // Page 5
    if( document.getElementById('recurrentSlider')){

        //default
        $('input[name="recurrent"]').val(3);

        $( "#recurrentSlider" ).slider({
            min: 3,
            max: 15,
            change: function( event, ui ) {
                $('input[name="recurrent"]').val(ui.value);
                $('#recurrentValue').html(ui.value);
            }
        });
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
