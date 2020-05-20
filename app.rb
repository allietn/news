require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  key = "0bb0e1f7b7128d9b1de7b337094e4002" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # make the call
   @forecast = HTTParty.get(url).parsed_response.to_hash
    i = 1
    for day in @forecast["daily"]
        puts "On day #{i}, high: #{day["temp"]["max"]} and #{day["weather"][0]["description"]}"
        i = i+1
    end
  ### Get the news
  view 'news'
end
