Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

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

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # User for password reset
  config.action_mailer.default_url_options = { host: 'localhost', port: '3000' }

  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS', 
      aws_access_key_id: Figaro.env.aws_access_key_id, 
      aws_secret_access_key: Figaro.env.aws_secret_access_key
    }

  config.fog_directory = 'beergarden'
  # config.asset_host = 'http://s3.amazonaws.com/beergarden'
  config.fog_public = true
  end


  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.mandrillapp.com",
    :port                 => 587,
    :enable_starttls_auto => true,
    :user_name            => Figaro.env.smtp_username,
    :password             => Figaro.env.smtp_password,
    :domain               => Figaro.env.smtp_domain,
    :authentication       => 'plain'
  }

  # client = Twitter::Streaming::Client.new do |config|
  #   config.consumer_key        = Figaro.env.twitter_consumer_key
  #   config.consumer_secret     = Figaro.env.twitter_consumer_secret
  #   config.access_token        = Figaro.env.twitter_access_token
  #   config.access_token_secret = Figaro.env.twitter_access_token_secret
  # end
end
