var pressedKeys = [];

$(document).ready(function(){
    $(document.body).keydown(function (evt) {
        pressedKeys.push(evt.keyCode);
        var combination = [17,16,68]
        if($(pressedKeys).not(combination).length == 0 && $(combination).not(pressedKeys).length == 0){
            $('.washcost-popup .reveal-modal.debugger').foundation('reveal', 'open');
        }
    });
    $(document.body).keyup(function (evt) {
        pressedKeys = [];
    });
    $('.debug-trigger-button').click(function(){
        $('.washcost-popup .reveal-modal.debugger').foundation('reveal', 'open');
    });
});
