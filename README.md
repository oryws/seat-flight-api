# Get your flight's seats

API server that takes inputs for a one way flight (Departure time, from airport code, to airport code, flight number) and returns a map of the seats

The server is temporarly available at `https://seats-api.serveo.net` and `https://radiant-headland-74749.herokuapp.com`.

Here's a fast way of testing it:
```
curl 'https://seats-api.serveo.net/api/v1/seats/westjet?departureTime=2019-05-26T10:30:00&fromAirportCode=YYC&toAirportCode=SFO&flightNumber=1508' | json_pp
curl 'https://radiant-headland-74749.herokuapp.com/api/v1/seats/westjet?departureTime=2019-05-30T16:50:00&fromAirportCode=YVR&toAirportCode=LGW&flightNumber=0022' | json_pp
```

## Prerequisites:
This service runs on `ruby 2.5.3`.
[how to install](https://www.ruby-lang.org/es/documentation/installation/)

RECOMMENDATION: [Use RVM](https://rvm.io/rvm/install())

To install the gems, we use bundle
```gem install bundler```

## Installing
```bundle install```

## Running
```rackup```

To make sure everything's running smoothly, make GET a request to `localhost:9292/api/status`

```
curl 'localhost:9292/api/status'
```

You should get this response:
```
{
  "status": "ok"
}
```

## Try it out
Make GET a request to `localhost:9292/api/v1/seats/westjet` with the params: `departureTime`, `fromAirportCode`, `toAirportCode` and `flightNumber`.

```
curl 'localhost:9292/api/v1/seats/westjet?departureTime=2019-05-26T10:30:00&fromAirportCode=YYC&toAirportCode=SFO&flightNumber=1508' | json_pp
```
(`json_pp` makes sure the formatting is pretty (or just use postman man))

You should get a response like this:

```
{
  "flight": [
    {
      "first_class": [
        "|  1A     $0 |              |  1C     $0 ||  1D     $0 |              |  1F     $0 |",
        "|  2A     $0 |              |  2C     $0 ||  2D     $0 |              |  2F     $0 |",
        "|  OCCUPIED  |              |  OCCUPIED  ||  3D     $0 |              |  3F     $0 |"
      ]
    }, {
      "economy_class": [
        "|  4A $43.80 ||  4B $43.80 ||  4C $43.80 ||  4D $43.80 ||  4E $43.80 ||  4F $43.80 |",
        "|  OCCUPIED  ||  OCCUPIED  ||  5C $28.10 ||  5D $43.80 ||  OCCUPIED  ||  OCCUPIED  |",
        "|  6A $28.10 ||  6B $28.10 ||  OCCUPIED  ||  6D $43.80 ||  OCCUPIED  ||  OCCUPIED  |",
        "|  7A $28.10 ||  7B $28.10 ||  OCCUPIED  ||  7D $43.80 ||  7E $43.80 ||  7F $43.80 |",
        "|  8A $28.10 ||  8B $28.10 ||  8C $28.10 ||  OCCUPIED  ||  8E $28.10 ||  OCCUPIED  |",
        "|  9A $28.10 ||  9B $28.10 ||  9C $28.10 ||    N/A     ||    N/A     ||  OCCUPIED  |",
        "| 10A $28.10 || 10B $28.10 || 10C $28.10 || 10D $28.10 || 10E $28.10 || 10F $28.10 |",
        "| 11A $47.70 || 11B $47.70 || 11C $47.70 || 11D $47.70 || 11E $47.70 || 11F $47.70 |",
        "| 12A $28.10 || 12B $28.10 || 12C $28.10 || 12D $28.10 || 12E $28.10 || 12F $28.10 |",
        "| 13A $28.10 || 13B $28.10 || 13C $28.10 ||    N/A     ||    N/A     ||    N/A     |",
        "| 14A $28.10 || 14B $28.10 || 14C $28.10 ||    N/A     ||    N/A     ||    N/A     |",
        "| 15A $28.10 || 15B $28.10 || 15C $28.10 || 15D $28.10 || 15E $28.10 || 15F $28.10 |",
        "| 16A $28.10 || 16B $28.10 || 16C $28.10 || 16D $28.10 || 16E $28.10 || 16F $28.10 |",
        "| 17A $28.10 || 17B $28.10 || 17C $28.10 || 17D $28.10 || 17E $28.10 || 17F $28.10 |",
        "| 18A $28.10 || 18B $28.10 || 18C $28.10 || 18D $28.10 || 18E $28.10 || 18F $28.10 |",
        "| 19A $28.10 || 19B $28.10 || 19C $28.10 || 19D $28.10 || 19E $28.10 || 19F $28.10 |",
        "| 20A $28.10 || 20B $28.10 || 20C $28.10 || 20D $28.10 || 20E $28.10 || 20F $28.10 |",
        "| 21A $28.10 || 21B $28.10 || 21C $28.10 || 21D $28.10 || 21E $28.10 || 21F $28.10 |",
        "| 22A $28.10 || 22B $28.10 || 22C $28.10 || 22D $28.10 || 22E $28.10 || 22F $28.10 |",
        "|    N/A     ||    N/A     ||    N/A     ||    N/A     ||    N/A     ||    N/A     |",
        "                                          |    N/A     ||    N/A     |              "
      ]
    }
  ]
}
```
