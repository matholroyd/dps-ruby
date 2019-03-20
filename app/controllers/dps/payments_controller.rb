require_dependency "dps/application_controller"

module Dps
  class PaymentsController < ApplicationController
    before_action :load_endpoint

    def new
      if @endpoint_renderer.present?
        @endpoint_renderer.instance_method(:render_new_payment).bind(self).call
      else
        render json: "Could not process endpoint '#{@endpoint}'", status: 501
      end
    end

    private
  
    def load_endpoint
      @endpoint = params[:endpoint]
      @endpoint_renderer = Dps.get_new_payment_renderer(@endpoint)
    end
    
    def payment_params
      params.require(:payment).permit(
        :payer,
        :recipient,
        
        transaction: [
          :type,
          :ref
        ]
      )
    end

  end
end
