require_dependency "dps/application_controller"

module Dps
  class InfoController < ApplicationController

    def show
      render json: "Working!"
    end

  end
end
