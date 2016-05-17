require 'rails_helper'

RSpec.describe ChargeCard, type: :model do

  describe "process" do
    
    it "returns charge data" do
      credit_card_params = { number: "4242 4242 4242 4242", name: "Marco Montes" }
      credit_card_response = CreditCard.process(credit_card_params)
      token = credit_card_response[:id]

      charge_params = { token_id: token, amount: 1000, description: "Charge test" }
      charge_response = ChargeCard.process(charge_params)

      expect(charge_response[:id]).to be_present
      expect(charge_response[:id].first(3)).to eq "ch_"
      expect(charge_response[:amount]).to eq 1000
    
    end

    it "returns error message with invalid token" do
      charge_params = { token_id: '123', amount: 1000, description: "Charge test" }
      charge_response = ChargeCard.process(charge_params)

      expect(charge_response[:message]).to eq "Invalid Token"
    end

  end

end
