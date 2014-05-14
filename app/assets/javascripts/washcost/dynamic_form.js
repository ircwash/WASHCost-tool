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

  function addError (msg, type) {
    $('<div class="standalone_form--message" id="' + type+ '">' + msg + '</div>').insertAfter('.standalone_form--heading');
  }


  function init() {
    // Handles the signin process, basic validation
    $('form#new_user').on('submit', function () {
      
      var email = $('input#user_email').val();
      var password_confirmation = $('input#user_password_confirmation').val();
      var password = $('input#user_password').val();
      var errors = true;

      $('#email-error,#password-error').remove();

      if ($('input#user_password').length > 0 && !validateInput(password)) {
        var msg = $('input#user_password').attr('data-req-msg');
        addError(msg, 'password-error');
        errors = false;
      } 

      if ($('input#user_password_confirmation').length > 0 && errors && !validatePassword(password)) {
        var msg = $('input#user_password').attr('data-pwd-short');
        addError(msg, 'password-error');
        errors = false;
      } 

      if ($('input#user_password_confirmation').length > 0 && password != password_confirmation) {
        var msg = $('input#user_password_confirmation').attr('data-pwd-match');
        addError(msg, 'password-error');
        errors = false;
      }

      if (!validateEmail(email)) {
        var msg = $('input#user_email').attr('data-email-valid');
        addError(msg, 'email-error');
        errors = false;
      }

      return errors;
    });

    $('[data-dynamic_form]' ).find('input[name],select[name]').on( 'change', function() {
      var form = $(this).parents('[data-dynamic_form]'),
          url  = form.data( 'dynamic_form' ),
          page = window.location.href.split('/')[window.location.href.split('/').length-1];

      // Removes on submit
      $(this).parents('[data-dynamic_form]').find('[data-currency]').each(function() {
        var re = / \(([^}]+)\)/g
        $(this).val($(this).val().replace(re, ''));
      });

      // Removes on submit
      $(this).parents('[data-dynamic_form]').find('[data-percentage]').each(function() {
        $(this).val($(this).val().replace('%', ''));
      });

      // Forces a selection (default = Don't know) for any enabled selects that have not been set on submit
      /*if (page === 'service_level') {
        $('form#new_advanced_water_questionnaire').find( 'select:enabled' ).each( function () { 
          if (this.selectedIndex === 0)
            this.selectedIndex = this.length-1;
        });
      }*/

      form.ajaxSubmit( { url:url, success:function( result ) {
        // trigger notification

        // adds back in after form submit
        $('[data-dynamic_form]').find('[data-currency]').each(function() {
          var re = / \(([^}]+)\)/g
          var value = $(this).val().replace(re, '');
          var currency = re.exec($(this).attr('placeholder'))[0];
          if (value === '' || value === null) return;
          $(this).val(value + currency);
        });

        // adds back in after form submit
        $('[data-dynamic_form]').find('[data-percentage]').each(function() {
          var value = $(this).val().replace(/%/g, '');
          if (value === '' || value === null) return;
          $(this).val(value + '%');
        });

        form.trigger( 'ajax_submit', result );
      } } );
    } );
  }


  init();
} );

