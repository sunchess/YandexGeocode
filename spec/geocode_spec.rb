require "rubygems"
require 'rspec'
require 'open-uri'
require File.dirname(__FILE__) + "/../lib/yandex_geocode/geocode"
include YandexGeocode

describe Geocode do
  before(:all) do
    @test_key = "TestApiKey"
    @json_test = IO.read(File.dirname(__FILE__) + "/json_test")
    @geo = Geocode.new(@test_key)
  end

  describe "should have method" do
    it "get_and_parse" do
      @geo.should respond_to(:get_and_parse)
    end

    it "get" do
      @geo.should respond_to(:get)
    end

    it "parse" do
      @geo.should respond_to(:parse)
    end

  end

  it "should parse json" do
    @geo.stub(:open).and_return(@json_test)
    @json_test.stub(:read).and_return(@json_test)
    @geo.get("Москва")
    @geo.parse
    @geo.result.should == ["37.609218", "55.753559"]
  end

end
