##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

require 'spec_helper.rb'

describe 'UserDefinedMessage' do
  it "can create" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.api.v2010.accounts('ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                       .calls('CAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                       .user_defined_messages.create(content: 'content')
    }.to raise_exception(Twilio::REST::TwilioError)

    values = {'Content' => 'content', }
    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'post',
        url: 'https://api.twilio.com/2010-04-01/Accounts/ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Calls/CAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/UserDefinedMessages.json',
        data: values,
    ))).to eq(true)
  end

  it "receives create responses" do
    @holodeck.mock(Twilio::Response.new(
        201,
      %q[
      {
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "call_sid": "CAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "sid": "KXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "date_created": "Wed, 18 Dec 2019 20:02:01 +0000"
      }
      ]
    ))

    actual = @client.api.v2010.accounts('ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                              .calls('CAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                              .user_defined_messages.create(content: 'content')

    expect(actual).to_not eq(nil)
  end
end