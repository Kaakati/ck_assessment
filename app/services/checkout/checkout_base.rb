class Checkout::CheckoutBase
  include HTTParty
  base_uri 'https://api.sandbox.checkout.com'
end
