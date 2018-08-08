class MainController < ApplicationController
  def index
    require 'uri'
    require 'net/http'
    require 'json'

    @first_name = Array.new
    @email_address = Array.new
    @title = Array.new

    url = URI("https://api.salesloft.com/v2/people.json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = 'Bearer ' + ENV["API_KEY"]
    request["Cache-Control"] = 'no-cache'


    response = http.request(request)
    
    @body = JSON.parse(response.body)['data']
    @body.each do |body|
      @first_name << body['first_name']
      @email_address << body['email_address']
      @title << body['title']

    end

  end
end