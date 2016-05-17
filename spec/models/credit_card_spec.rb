require 'rails_helper'

RSpec.describe CreditCard, type: :model do

  describe "process" do
    
    it "returns token and card data" do
      params = { number: "4242 4242 4242 4242", name: "Marco Montes" }
      response = CreditCard.process(params)
      
      expect(response[:id]).to be_present
      expect(response[:bin]).to eq "424242"
      expect(response[:name]).to eq "Marco Montes"
    end

    it "returns error message with invalid card data" do
      params = { number: "4242 4242 4242 4249", name: "Marco Montes" }
      response = CreditCard.process(params)
      
      expect(response[:id]).to_not be_present
      expect(response[:message]).to eq "Invalid Card"
    end

  end

  describe "generate token" do

    it "generates a token" do
      token = CreditCard.generate_token

      expect(token).to be_present
      expect(token).to be_a String
      expect(token.first(4)).to eq "tok_"
    end

  end

end
