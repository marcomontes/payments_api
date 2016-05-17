class CreditCard

  def self.process(params)
    card_number = params[:number].delete("\s")

    card_object = CreditCardValidations::Detector.new(card_number)

    if card_object.valid?

      card_bin_number = card_number[0..5]
      card_brand      = card_object.brand_name
      card_last_4     = card_number.last(4)
      card_token      = generate_token

      response = {
        id:         card_token,
        name:       params[:name],
        bin:        card_bin_number,
        exp_month:  params[:exp_month],
        exp_year:   params[:exp_year],
        brand:      card_brand,
        last4:      card_last_4
      }

      $redis.set card_token, response.to_json
    else
      response = { message: "Invalid Card" }
    end

    response
  end

  def self.generate_token
    token = "tok_" + SecureRandom.urlsafe_base64

    loop do
      break token unless $redis.exists(token)
    end
  end

end
