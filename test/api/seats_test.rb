require 'test_helper'
require 'application'

class API::Version1::SeatsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    API::Root
  end

  def test_get_status_ok
    get '/api/status'

    assert last_response.ok?
    assert_equal({ 'status' => 'ok' }.to_json, last_response.body)
  end
end
