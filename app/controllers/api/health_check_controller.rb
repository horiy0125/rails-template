class Api::HealthCheckController < ApplicationController

  def index
    render json: {
      status: "OK",
      message: "Working normally"
    }, status: :ok
  end

end
