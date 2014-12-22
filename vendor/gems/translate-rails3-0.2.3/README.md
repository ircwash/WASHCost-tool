Translate
=========

This plugin provides a web interface for translating Rails I18n texts (requires Rails 3.0 or higher) from one locale to another. The plugin has been tested only with the simple I18n backend that ships with Rails. I18n texts are read from and written to YAML files under config/locales.

To translate to a new locale you need to add a YAML file for that locale that contains the locale as the top key and at least one translation.

Please note that there are certain I18n keys that map to Array objects rather than strings and those are currently not dealt with by the translation UI. This means that Rails built in keys such as date.day_names need to be translated manually directly in the YAML file.

To get the translation UI to write the YAML files in UTF8 you need to install the ya2yaml gem.

The translation UI finds all I18n keys by extracting them from I18n lookups in your application source code. In addition it adds all :en and default locale keys from the I18n backend.

Strings in the UI can have an "Auto Translate" link (if configured, see below),
which will send the original text to translation API and will input the returned
translation into the form field for further clean up and review prior to saving.


Rake Tasks
----------

In addition to the web UI this plugin adds the following rake tasks:

translate:untranslated
translate:missing
translate:remove_obsolete_keys
translate:merge_keys
translate:google
translate:changed

The missing task shows you any I18n keys in your code that do not have translations in the YAML file for your default locale, i.e. config/locales/sv.yml.

The merge_keys task is supposed to be used in conjunction with Sven Fuch's Rails I18n TextMate bundle (http://github.com/svenfuchs/rails-i18n/tree/master). Texts and keys extracted with the TextMate bundle end up in the temporary file log/translations.yml. When you run the merge_keys rake task the keys are moved over to the corresponding I18n locale file, i.e. config/locales/sv.yml. The merge_keys task also checks for overwrites of existing keys by warning you that one of your extracted keys already exists with a different translation.

The google task is used for auto translating from one locale to another using Google Translate.
* Note: this task is currently broken, as Google is now charging for the Google Translate service.

The changed rake task can show you between one YAML file to another which keys have had their texts changed.

Installation
------------

Add to your Gemfile:

    gem 'translate-rails3', :require => 'translate', :group => :development

Now visit /translate in your web browser to start translating.

Configuration
-------------

(Optional) You can configure from_locales and to_locales explicitly through your environments/development.rb by adding

	config.from_locales = [:en]
	config.to_locales = [:ja, :es, :fr]

Where [:en] and [:ja, :es, :fr] could be replaced by locale list of your choice.

(Optional) You can bring back "Auto Translate" support by specifying Bing AppId or
Google API Key in config/initializers/translate.rb with:

    Translate.app_id = 'myappid'

or

    Translate.api_key = 'mysecretkey'


Dependencies
------------

- Rails 3.0 or higher
- The ya2yaml gem if you want your YAML files written in UTF8 encoding.

Authors
-------

- Peter Marklund (programming)
- Joakim Westerlund (web design)
- Milan Novota (initial Rails 3 support)
- Roman Shterenzon (Rails 3 cleanup and gem packaging)
- Ichiro Yamamoto

Many thanks to http://newsdesk.se for sponsoring the development of this plugin.

Copyright (c) 2009 Peter Marklund, released under the MIT license
