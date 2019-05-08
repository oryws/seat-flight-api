require 'net/http'
require 'json'

class FlightNotFound < StandardError; end

class Flight
  def initialize(
    departure_time, from_code, to_code, flight_number, airline_code
  )
    @departure_time = departure_time
    @from_code = from_code
    @to_code = to_code
    @flight_number = flight_number
    @airline_code = airline_code
  end

  def seats
    strawberry = seats_by_class('strawberry')
    economy = seats_by_class('economy')

    # Array so the result is always ordered
    [{ first_class: format_seats(strawberry) },
     { economy_class: format_seats(economy) }]
  end

  private

  def format_seats(seats)
    rows = seats.dig('aircraft', 'deck', 'cabin', 'rows')
    return [] if rows.nil?

    rows.map do |row|
      row['seats'].reduce('') do |prev, seat|
        prev + format_seat(seat)
      end
    end
  end

  def format_seat(seat)
    return '              ' if seat.dig('characteristics', 'NO_SEAT')
    return '|    N/A     |' if seat.dig('characteristics', 'OFFERED_LAST')
    return '|  OCCUPIED  |' if seat['occupied']

    "| #{seat['seatNumber'].rjust(3, ' ')} #{"$#{seat['price']}".rjust(6, ' ')} |"
  end

  def seats_by_class(f_level)
    uri = URI('https://apiw.westjet.com/bookingservices/seatmap')

    params = {
      flightInfo: flight_info(f_level),
      segment: segment,
      pointOfSale: point_of_sale
    }

    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    raise FlightNotFound unless res.kind_of? Net::HTTPSuccess

    JSON.parse(res.body)
  end

  def flight_info(f_level)
    [{
      flight: [{
        fareClass: fare_class(f_level),
        flightNumber: @flight_number,
        airlineCodeOperating: @airline_code,
        operatingFlightNumber: @flight_number,
        airlineCodeMarketing: @airline_code,
        departureDateTime: @departure_time.strftime('%Y-%m-%dT%H:%M:%S'),
        arrivalDateTime: arrival_time.strftime('%Y-%m-%dT%H:%M:%S'),
        arrival: @to_code,
        departure: @from_code
      }]
    }].to_json
  end

  def fare_class(f_level)
    return 'E' if f_level == 'economy'
    return 'W' if f_level == 'strawberry'
  end

  def arrival_time
    # We could try and calculate this, but it's irrelevant for the request
    @departure_time + 1
  end

  def segment
    # Always the same
    1
  end

  def point_of_sale
    # Always the same
    'QkFC'
  end
end
