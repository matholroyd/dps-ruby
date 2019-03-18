require_dependency "dps/application_controller"

module Dps
  class PaymentsController < ApplicationController

    def new
      render json: "Working => #{params[:endpoint]}"
    end

  end
end
