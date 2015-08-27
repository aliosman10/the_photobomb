require 'sinatra'
require 'unirest'

get '/' do
	@title = 'Photos'
	@photos = recent_photos
	erb :all_photos
end

def recent_photos(hashtag = "Chelseafc", resolution = "thumbnail")
		@photos = []
		instagram_response = "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=f71df6aade944c44a10b2adc9de60f07"
		response = Unirest.get(instagram_response)
		photos_array = response.body["data"]

		photos_array.each do |photo|
			image = photo["images"][resolution]["url"]
			@photos << image
		end

		@photos
end

get '/:resolution/:hashtag' do
	@title = 'Photos'
	@photos = recent_photos(params[:hashtag],params[:resolution])
	erb :all_photos
end

post '/search' do
	@title = params["hashtag"].capitalize
	@photos = recent_photos(params["hashtag"], params["resolution"])
	erb :all_photos
end



