class MainController < ApplicationController

  def index

     #LEVEL 1
    
    # Initialize variables to be arrays
    @first_name = Array.new
    @email_address = Array.new
    @title = Array.new

    # Gets body of API call and initializes first name, email, and job title
    call(@first_name, @email_address, @title)
 
  end

  def displayFreq
    
    #Define a hash for the frequencies
    @frequency = Hash.new(0)

    # Initialize variables to be arrays
    @first_name = Array.new
    @email_address = Array.new
    @title = Array.new

    # Gets body of API call and initializes first name, email, and job title
    call(@first_name, @email_address, @title)

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


  # Makes call to SalesLoft API
  def salesApi
    require 'uri'
    require 'net/http'
    require 'json'

    #Arrays for each category
    
    @frequency = Hash.new(0)

    url = URI("https://api.salesloft.com/v2/people.json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = 'Bearer ' + ENV["API_KEY"]

    response = http.request(request)
    
    @body = JSON.parse(response.body)['data']
    return @body
  end


  # Funciton to initialize variables
  def call(first_name, email_address, title)

    # Call SalesLoft API and get the body of the response
    @body = salesApi()

    # Funnel JSON into appropiate variable
    @body.each do |body|
      first_name << body['first_name']
      email_address << body['email_address']
      title << body['title']
    end
  end

end