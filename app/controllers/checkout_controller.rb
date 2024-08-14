class CheckoutController < ApplicationController
  skip_before_action :verify_authenticity_token

  def cart

  end

  def tokenization
    card_token = params["cko-card-token"]

  end

  def checkout
    puts params
    puts params["cko-card-token"]
  end
end
