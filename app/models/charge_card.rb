class ChargeCard

  def self.process(params)
    token = params[:token_id]

    if token && $redis.exists(token)
      charge(params)
    else
      { message: "Invalid Token" }
    end
  end


  def self.charge(params)
    token       = params[:token_id]
    amount      = params[:amount]
    description = params[:description]

    redis_data = $redis.get token
    json_data  = JSON.parse redis_data
    charge_id  =  "ch_" + SecureRandom.urlsafe_base64

    {
      id: charge_id,
      amount: amount,
      description: description,
      status: 'paid',
      name: json_data["name"],
      bin: json_data["bin"],
      exp_month: json_data["exp_month"],
      exp_year: json_data["exp_year"],
      brand: json_data["brand"],
      last4: json_data["last4"]
    }
  end

end
