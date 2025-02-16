##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

require 'spec_helper.rb'

describe 'DeviceConfig' do
  it "can read" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                           .device_configs.list()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://microvisor.twilio.com/v1/Devices/UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Configs',
    ))).to eq(true)
  end

  it "receives read_empty responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "configs": [],
          "meta": {
              "page": 0,
              "page_size": 50,
              "first_page_url": "https://microvisor.twilio.com/v1/Devices/UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Configs?PageSize=50&Page=0",
              "previous_page_url": null,
              "url": "https://microvisor.twilio.com/v1/Devices/UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Configs?PageSize=50&Page=0",
              "next_page_url": null,
              "key": "configs"
          }
      }
      ]
    ))

    actual = @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .device_configs.list()

    expect(actual).to_not eq(nil)
  end

  it "receives read_full responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "configs": [
              {
                  "device_sid": "UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "key": "first",
                  "value": "some value",
                  "date_updated": "2021-01-01T12:34:56Z",
                  "url": "https://microvisor.twilio.com/v1/Devices/UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Configs/first"
              },
              {
                  "device_sid": "UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "key": "second",
                  "value": "some value",
                  "date_updated": "2021-01-01T12:34:57Z",
                  "url": "https://microvisor.twilio.com/v1/Devices/UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Configs/second"
              }
          ],
          "meta": {
              "page": 0,
              "page_size": 50,
              "first_page_url": "https://microvisor.twilio.com/v1/Devices/UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Configs?PageSize=50&Page=0",
              "previous_page_url": null,
              "url": "https://microvisor.twilio.com/v1/Devices/UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Configs?PageSize=50&Page=0",
              "next_page_url": null,
              "key": "configs"
          }
      }
      ]
    ))

    actual = @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .device_configs.list()

    expect(actual).to_not eq(nil)
  end

  it "can fetch" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                           .device_configs('key').fetch()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://microvisor.twilio.com/v1/Devices/UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Configs/key',
    ))).to eq(true)
  end

  it "receives fetch responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "device_sid": "UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "key": "first",
          "value": "some value",
          "date_updated": "2021-01-01T12:34:57Z",
          "url": "https://microvisor.twilio.com/v1/Devices/UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Configs/first"
      }
      ]
    ))

    actual = @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .device_configs('key').fetch()

    expect(actual).to_not eq(nil)
  end

  it "can create" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                           .device_configs.create(key: 'key', value: 'value')
    }.to raise_exception(Twilio::REST::TwilioError)

    values = {'Key' => 'key', 'Value' => 'value', }
    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'post',
        url: 'https://microvisor.twilio.com/v1/Devices/UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Configs',
        data: values,
    ))).to eq(true)
  end

  it "receives create_account_config responses" do
    @holodeck.mock(Twilio::Response.new(
        201,
      %q[
      {
          "device_sid": "UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "key": "first",
          "value": "some value",
          "date_updated": "2021-01-01T12:34:56Z",
          "url": "https://microvisor.twilio.com/v1/Devices/UVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Configs/first"
      }
      ]
    ))

    actual = @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .device_configs.create(key: 'key', value: 'value')

    expect(actual).to_not eq(nil)
  end

  it "can delete" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                           .device_configs('key').delete()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'delete',
        url: 'https://microvisor.twilio.com/v1/Devices/UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Configs/key',
    ))).to eq(true)
  end

  it "receives delete responses" do
    @holodeck.mock(Twilio::Response.new(
        204,
      nil,
    ))

    actual = @client.microvisor.v1.devices('UVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .device_configs('key').delete()

    expect(actual).to eq(true)
  end
end