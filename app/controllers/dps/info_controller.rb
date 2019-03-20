require_dependency "dps/application_controller"

module Dps
  class InfoController < ApplicationController

    def show
      if Dps.endpoints.present?
        render json: "Endpoints are: #{Dps.endpoints}"
      else
        render json: "No endpoints specified", status: 501
      end
    end

  end
end
