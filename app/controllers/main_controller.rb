class MainController < ApplicationController
  def index
    require 'uri'
    require 'net/http'
    require 'json'

    url = URI("https://api.salesloft.com/v2/people.json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = 'Bearer ' + ENV["API_KEY"]
    request["Cache-Control"] = 'no-cache'


    response = http.request(request)
    @body = response.read_body
  end
end