require_relative '../../lib/flight'

module API
  module Version1
    class Seats < Grape::API
      format :json
      version 'v1', using: :path
      content_type :json, 'application/json'

      resource :seats do
        params do
          requires :departureTime, type: Time
          requires :fromAirportCode, type: String
          requires :toAirportCode, type: String
          requires :flightNumber, type: String
        end

        get '/westjet' do
          departure_time = params['departureTime']
          from_code = params['fromAirportCode']
          to_code = params['toAirportCode']
          flight_number = params['flightNumber']
          airline_code = 'WS'

          flight = Flight.new(
            departure_time, from_code, to_code, flight_number, airline_code
          )

          {
            flight: flight.seats
          }
        rescue FlightNotFound
          error! 'Flight not found', 404
        end
      end
    end
  end
end
