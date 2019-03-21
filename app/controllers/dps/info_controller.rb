require_dependency "dps/application_controller"

module Dps
  class InfoController < ApplicationController

    def show
      if Dps.endpoints.blank?
        render json: "No endpoints specified", status: 501
      elsif Dps.domains.blank?
        render json: "No domains specified", status: 501
      else
        render json: {
          endpoints: Dps.endpoints,
          domains: Dps.domains,          
        }
      end
    end

  end
end
