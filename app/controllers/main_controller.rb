class MainController < ApplicationController
  def index
    require 'uri'
    require 'net/http'
    require 'json'

    #Arrays for each category
    @first_name = Array.new
    @email_address = Array.new
    @title = Array.new
    @frequency = Hash.new(0)

    url = URI("https://api.salesloft.com/v2/people.json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = 'Bearer ' + ENV["API_KEY"]

    response = http.request(request)
    
    @body = JSON.parse(response.body)['data']

    #LEVEL 1

    #Grabs first name, email, and job title from each available Person
    @body.each do |body|
      @first_name << body['first_name']
      @email_address << body['email_address']
      @title << body['title']
    end

    #LEVEL 2
    @test = "jimmy_mcmahon@salesloft.com"
    #Iterate over each character and put them in to the hash
    @email_address.each do |email|
      email = email.split('')
      email.each do |e|
        @frequency[e] += 1
      end
    end

    #Sort in descending order
    @frequency = @frequency.sort_by {|_key, value| value}.reverse

  end
end