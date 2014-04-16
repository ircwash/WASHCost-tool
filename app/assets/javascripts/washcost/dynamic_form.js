$( document ).ready( function()
{
  'use strict';

  function validateEmail (email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
  } 

  function validateInput (str) { 
    if (str === null || str === '' || str === undefined)
      return false;

    return true;
  } 

  function validatePassword (str) { 
    if (str.length < 8)
      return false;

    return true;
  } 


  function init()
  {
    // Handles the signin process, basic validation
    $('form#new_user').on('submit', function () {
      
      var email = $('input#user_email').val();
      var password_confirmation = $('input#user_password_confirmation').val();
      var password = $('input#user_password').val();
      var errors = true;

      $('#email-error,#password-error').remove();

      if (!validateInput(password)) {
        $('<div class="standalone_form--message" id="password-error">A password is required</div>').insertAfter('.standalone_form--heading');
        errors = false;
      } 

      if ($('input#user_password_confirmation').length > 0 && errors && !validatePassword(password)) {
        $('<div class="standalone_form--message" id="password-error">Password too short (minimum 8 characters)</div>').insertAfter('.standalone_form--heading');
        errors = false;
      } 

      if ($('input#user_password_confirmation').length > 0 && password != password_confirmation) {
        $('<div class="standalone_form--message" id="password-error">Passwords don\'t match</div>').insertAfter('.standalone_form--heading');
        errors = false;
      }

      if (!validateEmail(email)) {
        $('<div class="standalone_form--message" id="email-error">Email address must be valid</div>').insertAfter('.standalone_form--heading');
        errors = false;
      }

      return errors;
    });

    $( '[data-dynamic_form]' ).find( 'input[name],select[name]' ).on( 'change', function()
    {
      var form = $( this ).parents( '[data-dynamic_form]' ),
          url  = form.data( 'dynamic_form' ),
          page = window.location.href.split('/')[window.location.href.split('/').length-1];

      // Forces a selection (default = Don't know) for any enabled selects that have not been set on submit
      if (page === 'service_level') {
        $('form#new_advanced_water_questionnaire').find( 'select:enabled' ).each( function () { 
          if (this.selectedIndex === 0)
            this.selectedIndex = this.length-1;
        });
      }

      form.ajaxSubmit( { url:url, success:function( result ) {
        // trigger notification
        form.trigger( 'ajax_submit', result );
      } } );
    } );
  }


  init();
} );

