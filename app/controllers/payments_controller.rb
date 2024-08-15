class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    token = params["cko-card-token"]

    response = HTTParty.post(
      "https://api.sandbox.checkout.com/payments",
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer sk_sbox_fz477clto7att37tqnxk7gjgbm5"
      },
      body: {
        source: {
          type: "token",
          token: token
        },
        amount: 7040,
        currency: "EUR",
        reference: Random.hex,
        processing_channel_id: "pc_mkdax3ipzvwezd7f734ha2b2wa"
      }.to_json
    )

    result = response.parsed_response
    status = result["status"]

    render json: { status: status }
  end

  def hosted_payment
    response = HTTParty.post(
      "https://api.sandbox.checkout.com/hosted-payments",
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer sk_sbox_fz477clto7att37tqnxk7gjgbm5"
      },
      body: {
        "amount": 7040,
        "currency": "EUR",
        "reference": "ORD-#{Random.hex(6)}",
        "processing_channel_id": "pc_mkdax3ipzvwezd7f734ha2b2wa",
        "display_name": "Kaakati T-Shirts",
        "enabled_payment_methods": %w[card applepay googlepay klarna paypal],
        "capture": true,
        # "locale": "ar",
        "3ds": {
          "enabled": true
        },
        "billing": {
          "address": {
            "country": "DE"
          }
        },
        "customer": {
          "name": "Mohamad Kaakati",
          "email": "kaakati@example.com"
        },
        "items": [
          {
            "reference": Random.hex(5),
            "total_amount": 3200,
            "tax_amount": 320,
            "discount_amount": 0,
            "name": "Large, Basic Tee, Sienna",
            "quantity": 1,
            "unit_price": 3200
          },
          {
            "reference": Random.hex(5),
            "total_amount": 3200,
            "tax_amount": 320,
            "discount_amount": 0,
            "name": "Large, Basic Tee, Black",
            "quantity": 1,
            "unit_price": 3200
          }
        ],
        "success_url": "http://localhost:3000/payments/success",
        "failure_url": "http://localhost:3000/payments/failure",
        "cancel_url": "http://localhost:3000/cart"
      }.to_json
    )

    result = response.parsed_response
    puts result
    redirect_to result["_links"]["redirect"]["href"], allow_other_host: true
  end

  def success
    @payment_id = params["cko-payment-id"]
  end

  def failure
    @payment_id = params["cko-payment-id"]
  end
end
