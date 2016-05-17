module Api
  module V1

    class PaymentsController < ApplicationController
      
      def tokens
        response = CreditCard.process(params)
        render json: response
      end

      def charges
        response = ChargeCard.process(params)
        render json: response
      end

    end
  end
end
