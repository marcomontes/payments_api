require 'rails_helper'

RSpec.describe Api::V1::PaymentsController, :type => :controller do

  describe "process credit card" do

    it "get token with valid credit card data" do
      post :tokens, number: "4242 4242 4242 4242", name: "Marco Montes"
      
      json = JSON.parse(response.body)
      expect(json['id']).to be_present
      expect(json['name']).to eq "Marco Montes"
    end

    it "get error message with invalid credit card data" do
      post :tokens, number: "4242 4242 4242 4249", name: "Marco Montes"
      
      json = JSON.parse(response.body)
      expect(json['message']).to eq "Invalid Card"
    end

  end

  describe "charge credit card" do

    it "charge the credit card with valid token" do
      post :tokens, number: "4242 4242 4242 4242", name: "Marco Montes"
      token_json  = JSON.parse(response.body)
      token = token_json['id']

      post :charges, token_id: token, amount: 1000, description: "Charge test"
      charge_json  = JSON.parse(response.body)

      expect(charge_json['id']).to be_present
      expect(charge_json['amount']).to eq "1000"
    end

    it "charge fails with invalid token" do
      post :tokens, number: "4242 4242 4242 4242", name: "Marco Montes"
      token_json  = JSON.parse(response.body)
      token = token_json['id']

      post :charges, token_id: token + 'x', amount: 1000, description: "Charge test"
      charge_json  = JSON.parse(response.body)

      expect(charge_json['message']).to eq "Invalid Token"
    end

  end

end