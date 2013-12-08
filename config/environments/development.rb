Dummy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.paperclip_defaults = {

  }

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  config.secret_key_base = "cdab63868102d478561dfb67807d6e1e71814a342d8528bd4a874a2678a4fbeb35c2683f03b6c98c6cd9f48c8e3690d9745e049bfb399894be3c99f624ba3c27"


  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  Paperclip.options[:command_path] = "/usr/bin/" #EJ
  # Paperclip.options[:command_path] = "/usr/local/bin/convert" #Richard

end
