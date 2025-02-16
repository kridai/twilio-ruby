##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

require 'spec_helper.rb'

describe 'DomainCerts' do
  it "can update" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.messaging.v1.domain_certs('DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').update(tls_cert: 'tls_cert')
    }.to raise_exception(Twilio::REST::TwilioError)

    values = {'TlsCert' => 'tls_cert', }
    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'post',
        url: 'https://messaging.twilio.com/v1/LinkShortening/Domains/DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Certificate',
        data: values,
    ))).to eq(true)
  end

  it "receives update responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "certificate_sid": "CWaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "domain_name": "https://api.example.com",
          "domain_sid": "DNaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "date_expires": "2021-02-06T18:02:04Z",
          "date_created": "2021-02-06T18:02:04Z",
          "date_updated": "2021-02-06T18:02:04Z",
          "url": "https://messaging.twilio.com/v1/LinkShortening/Domains/DNaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Certificate",
          "validated": true
      }
      ]
    ))

    actual = @client.messaging.v1.domain_certs('DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').update(tls_cert: 'tls_cert')

    expect(actual).to_not eq(nil)
  end

  it "receives create responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "certificate_sid": "CWaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "domain_name": "https://api.example.com",
          "domain_sid": "DNaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "date_expires": "2021-02-06T18:02:04Z",
          "date_created": "2021-02-06T18:02:04Z",
          "date_updated": "2021-02-06T18:02:04Z",
          "url": "https://messaging.twilio.com/v1/LinkShortening/Domains/DNaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Certificate",
          "validated": true
      }
      ]
    ))

    actual = @client.messaging.v1.domain_certs('DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').update(tls_cert: 'tls_cert')

    expect(actual).to_not eq(nil)
  end

  it "can fetch" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.messaging.v1.domain_certs('DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').fetch()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://messaging.twilio.com/v1/LinkShortening/Domains/DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Certificate',
    ))).to eq(true)
  end

  it "receives fetch responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "certificate_sid": "CWaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "domain_name": "https://api.example.com",
          "domain_sid": "DNaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "date_expires": "2021-02-06T18:02:04Z",
          "date_created": "2021-02-06T18:02:04Z",
          "date_updated": "2021-02-06T18:02:04Z",
          "url": "https://messaging.twilio.com/v1/LinkShortening/Domains/DNaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Certificate",
          "validated": true
      }
      ]
    ))

    actual = @client.messaging.v1.domain_certs('DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').fetch()

    expect(actual).to_not eq(nil)
  end

  it "can delete" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.messaging.v1.domain_certs('DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').delete()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'delete',
        url: 'https://messaging.twilio.com/v1/LinkShortening/Domains/DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Certificate',
    ))).to eq(true)
  end

  it "receives delete responses" do
    @holodeck.mock(Twilio::Response.new(
        204,
      nil,
    ))

    actual = @client.messaging.v1.domain_certs('DNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').delete()

    expect(actual).to eq(true)
  end
end