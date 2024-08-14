class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  require 'net/http'
  require 'uri'
  require 'json'

  def create
    token = params["cko-card-token"]

    uri = URI.parse("https://api.sandbox.checkout.com/payments")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer sk_sbox_fz477clto7att37tqnxk7gjgbm5"

    request.body = JSON.dump({
                               "source" => {
                                 "type" => "token",
                                 "token" => token
                               },
                               "amount" => 11232,
                               "currency" => "EUR",
                               "reference" => "9bf2e1e9-193a-400a-86d5-debabc495238",
                               "processing_channel_id" => "pc_mkdax3ipzvwezd7f734ha2b2wa"
                             })

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    result = JSON.parse(response.body)
    status = result["status"]

    render json: { status: status }
  end
end
