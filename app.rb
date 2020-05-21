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

   currentTemp = "The current temperature in Evanston is #{@forecast["current"]["temp"]}"
   puts currentTemp
   
   i = 1
    for day in @forecast["daily"]
        puts "On day #{i}, high: #{day["temp"]["max"]} and #{day["weather"][0]["description"]}"
        i = i + 1
    end

    ### Get the news

    url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ff9b44dbf11945b1937666f6368c39a4"
    @news = HTTParty.get(url).parsed_response.to_hash

    top = []
    
    for headline in @news["articles"]
        top << "#{headline["title"]} happened. Learn more at #{headline["url"]}"
    end

    @todaystop = top[0,3]

    view 'news'

end
