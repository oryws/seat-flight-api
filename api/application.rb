# frozen_string_literal: true

require 'grape'

require './api/v1/seats'

module API
  class Root < Grape::API
    format :json
    prefix :api

    # Simple endpoint to get the current status of our API.
    get :status do
      { status: 'ok' }
    end

    mount Version1::Seats
  end
end

# Mounting the Grape application
Application = Rack::Builder.new do
  map '/' do
    run API::Root
  end
end
