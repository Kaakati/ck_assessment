class Checkout::Payment


  SECRET_KEY = "sk_sbox_fz477clto7att37tqnxk7gjgbm5"
  PUBLIC_KEY = "pk_sbox_75dvjddppbitqztp4si2rvghlef"
  def initialize(amount, card_token)

    request = {
      source: {
        type: "token",
        token: card_token
      },
      reference: Random.hex,
      amount: amount,
      currency: 'EUR',
      processing_channel_id: "pc_mkdax3ipzvwezd7f734ha2b2wa"
    }

    puts HTTParty.post('https://api.sandbox.checkout.com/payments', body: JSON.generate(request), headers: { 'Content-Type' => 'application/json', Authorization: SECRET_KEY })

  end



end
