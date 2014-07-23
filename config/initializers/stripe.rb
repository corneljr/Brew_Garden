Rails.configuration.stripe = {
  :publishable_key => Figaro.env.stripe_public_key,
  :secret_key      => Figaro.env.stripe_api_key
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]