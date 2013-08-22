$(document).ready(function(){
    // Option buttons that are checked should be highlighted.
    option_cheched = $( "[checked='checked']" )
    option_cheched.parent().addClass('ticked');
    // setting the default or initial value in info box
    target_select = $('input[name="target-select"]').data("target");
     $.ajax({
                url : "/water_basic/data_info_box",
                data : "trigger="+target_select+"&index="+option_cheched.val(),
                type : "POST",
            });
    // Page 3
    if( document.getElementById('populationSlider')){

        //default
        $('input[name="population"]').val(0);
        slider_display = function( event, ui ) {
            var value = Math.round(Number(LOG_SLIDER.expon(ui.value)/100)) * 100;
            $('input[name="population"]').val(value);
            var stringVal = '';
            stringValue= value.toLocaleString();
            $('#populationValue').html(stringValue);
        };

        $( "#populationSlider" ).slider({
            min: LOG_SLIDER.gMinPrice,
            max: LOG_SLIDER.gMaxPrice,
            change: slider_display,
            slide: slider_display
        });

        var slider_value = Number(document.getElementById('populationSlider').getAttribute("data-slider_value"));
        $( "#populationSlider" ).slider({value: LOG_SLIDER.logposition(slider_value)});
    }

    // Page 4
    if( document.getElementById('capitalSlider')){
        inputCapital = $('input[name="capital"]');
        capitalSlider = $( "#capitalSlider" );

        //default
        inputCapital.val(0);
        offset_cursor = 10;
        bar_slider_lenght = 850.0;
        slider_lenght = inputCapital.data('max-value') - inputCapital.data('min-value');
        above_value = inputCapital.data('above-value');
        below_value = inputCapital.data('below-value');
        step_slider = bar_slider_lenght/slider_lenght;
        css_above_value = above_value * step_slider + offset_cursor;
        css_below_value = below_value * step_slider + offset_cursor;

        //labels
        label_first = $('.labelScale li.first span');
        label_first.css('margin-left',css_below_value-offset_cursor+"px");
        label_last = $('.labelScale li.last span');
        label_last.css('margin-left',css_above_value-(bar_slider_lenght/2)-offset_cursor+"px");

        capitalSlider.css('backgroundPosition', css_above_value+"px 1px, "+css_below_value+"px 0px, 1px 0px");
        slider_display = function(event,ui) {
            inputCapital.val(ui.value);
            $('#capitalValue').html(ui.value);
        };
        capitalSlider.slider({
            min: inputCapital.data('min-value'),
            max: inputCapital.data('max-value'),
            change: slider_display,
            slide: slider_display
        });

        var slider_value = document.getElementById('capitalSlider').getAttribute("data-slider_value");
        capitalSlider.slider({value: slider_value});
    }

    // Page 5
    if( document.getElementById('recurrentSlider')){
        inputRecurrent = $('input[name="recurrent"]');
        recurrentSlider = $( "#recurrentSlider" );

        //default
        inputRecurrent.val(3);
        offset_cursor = 4;
        bar_slider_lenght = 850.0;
        slider_lenght = inputRecurrent.data('max-value') - inputRecurrent.data('min-value');
        above_value = inputRecurrent.data('above-value');
        below_value = inputRecurrent.data('below-value');
        step_slider = bar_slider_lenght/slider_lenght;
        css_above_value = above_value * step_slider + offset_cursor;
        css_below_value = below_value * step_slider + offset_cursor;

        //labels
        label_first = $('.labelScale li.first span');
        label_first.css('margin-left',css_below_value-offset_cursor+"px");
        label_last = $('.labelScale li.last span');
        label_last.css('margin-left',css_above_value-(bar_slider_lenght/2)-offset_cursor+"px");

        recurrentSlider.css('backgroundPosition', css_above_value+"px 1px, "+css_below_value+"px 0px, 1px 0px");
        slider_display = function( event, ui ) {
            inputRecurrent.val(ui.value);
            $('#recurrentValue').html(ui.value);
        };
        recurrentSlider.slider({
            min: inputRecurrent.data('min-value'),
            max: inputRecurrent.data('max-value'),
            change: slider_display,
            slide: slider_display
        });

        var slider_value = document.getElementById('recurrentSlider').getAttribute("data-slider_value");
        $( "#recurrentSlider" ).slider({value: slider_value});
    }

    // Page 6 (Time & Distance)
    if( document.getElementById('timeSlider')){

        //default
        $('input[name="time"]').val(0);
        timeSlider = $("#timeSlider");
        slider_display = function(event, ui) {
            $('input[name="time"]').val(ui.value);
            $('#timeValue').html(I18n["en"]["form"]["water_basic"]["time"]['answers']['a'+ui.value]);
        }
        timeSlider.slider({
            min: 0,
            max: 3,
            step: 1,
            change: slider_display,
            slide: slider_display
        });
        slider_value = document.getElementById('timeValue').getAttribute("data-slider_value");
        timeSlider.slider({value: slider_value});
    }
});
