# frozen_string_literal: true

require_relative '../lib/requester'

RSpec.describe Requester do
  describe '#call_api(google.com)' do
    let(:request) { Requester }
    let(:request_json) { request.call_api('google.com') }

    it 'should return a 200 response once connected' do
      # expect(request_json.class).to eql(Array)

      expect(request_json).to have_http_status(200)
    end
  end
end
