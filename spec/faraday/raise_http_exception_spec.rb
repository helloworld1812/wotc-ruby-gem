require File.expand_path('../../spec_helper', __FILE__)

describe FaradayMiddleWare::RaiseHttpException do
  def stub_user(status, body = '{}')
    stub_get('user').to_return(
      status: status,
      body: body,
      headers: { content_type: 'application/json; charset=utf-8' }
    )
  end

  {
    400 => WOTC::BadRequest,
    401 => WOTC::Unauthorized,
    403 => WOTC::Forbidden,
    404 => WOTC::NotFound,
    422 => WOTC::UnprocessableEntity,
    429 => WOTC::TooManyRequests,
    500 => WOTC::InternalServerError,
    502 => WOTC::BadGateway,
    503 => WOTC::ServiceUnavailable,
    504 => WOTC::GatewayTimeout
  }.each do |status, error|
    it "raises #{error} on #{status}" do
      stub_user(status)
      expect { WOTC::Client.new.current_user }.to raise_error(error)
    end
  end

  # These two passed through as if the request had succeeded, which is how a 403
  # came to look like a revoked token and a 405 like a valid answer.
  it 'raises ClientError on a 4xx it does not name' do
    stub_user(405, '{"message":"The GET method is not supported for route"}')
    expect { WOTC::Client.new.current_user }.to raise_error(WOTC::ClientError)
  end

  it 'raises ServerError on a 5xx it does not name' do
    stub_user(507)
    expect { WOTC::Client.new.current_user }.to raise_error(WOTC::ServerError)
  end

  it 'does not raise on a success' do
    stub_user(200, '{"id":516}')
    expect { WOTC::Client.new.current_user }.not_to raise_error
  end

  describe 'error grouping' do
    it 'files named 4xx statuses under ClientError' do
      expect(WOTC::Forbidden.new(nil_response)).to be_a(WOTC::ClientError)
      expect(WOTC::Unauthorized.new(nil_response)).to be_a(WOTC::ClientError)
    end

    it 'files named 5xx statuses under ServerError' do
      expect(WOTC::GatewayTimeout.new(nil_response)).to be_a(WOTC::ServerError)
      expect(WOTC::ServiceUnavailable.new(nil_response)).to be_a(WOTC::ServerError)
    end

    it 'keeps everything under Error so existing rescues still catch' do
      expect(WOTC::ClientError.new(nil_response)).to be_a(WOTC::Error)
      expect(WOTC::ServerError.new(nil_response)).to be_a(WOTC::Error)
    end

    def nil_response
      Faraday::Response.new(status: 500, body: {})
    end
  end

  # Pins the middleware order contract: the JSON parser must run before the
  # raise, so error bodies arrive parsed. CreateCompanyService's field-level
  # error reporting (raw_errors/error_sentence) depends on this.
  it 'delivers the parsed errors hash on a 4xx' do
    stub_user(400, '{"errors":{"ein":["The ein has already been taken."]}}')

    error = begin
      WOTC::Client.new.current_user
      nil
    rescue WOTC::BadRequest => e
      e
    end

    expect(error).not_to be_nil
    expect(error.raw_errors).to eq('ein' => ['The ein has already been taken.'])
    expect(error.error_sentence).to eq('The ein has already been taken.')
  end

  it 'keeps MissingRequiredArgument raisable with a plain message' do
    expect { raise WOTC::MissingRequiredArgument, 'employee_id is required' }
      .to raise_error(WOTC::MissingRequiredArgument, 'employee_id is required')
  end

  it 'reports the status and body on the error' do
    stub_user(403, '{"message":"Unauthorized Action Attempt"}')

    error = begin
      WOTC::Client.new.current_user
      nil
    rescue WOTC::Forbidden => e
      e
    end

    expect(error.message).to include('403')
    expect(error.message).to include('Unauthorized Action Attempt')
  end
end
