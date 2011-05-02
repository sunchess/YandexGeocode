require 'rubygems'
require 'json'
require 'open-uri'
module YandexGeocode
  #Get and parse yandex geocode service
  # if you use rails and have api key in file config/ya-map-api-key.yml
  # @geo = Geocode.new
  # or
  # @geo = Geocode.new("long_api_key")
  #
  # Get result from service
  # @geo.get("Москва")
  #
  # Parse json results
  # @geo.parse
  # @geo.result #return [37.617671,55.755768]
  # or
  # @geo.get_and_parse("Москва")
  # @geo.result #return ["37.609218", "55.753559"] strings in array!
  class Geocode

    attr_reader :result

    def initialize(key = nil)
      @api_key = key || ApiKey.get
      @json = ""
    end

    #Request to api url
    def get(geo_place)
      url = "http://geocode-maps.yandex.ru/1.x/?format=json&geocode=#{URI.escape( geo_place )}&key=#{@api_key}" 
      #url = "http://geocode-maps.yandex.ru/1.x/?format=json" 
      @json = open(url).read
    end

    def parse
      unless @json.empty?
        result = JSON.parse(@json)
        begin
          @result = result["response"]["GeoObjectCollection"]["featureMember"].first["GeoObject"]["Point"]["pos"].split
        rescue
          raise "Json result is not have point pos"
        end
      end
    end

    def find(geo_place)
      get(geo_place)
      parse
    end
  end
end
