require "uri"
require "net/http"

class BarsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @bars = get_bars_from_google(@event)
     @markers = @bars.map do |bar|
       {
         lat: bar.latitude,
         lng: bar.longitude,
       }
     end
  end

  def create
    @event = Event.find(params[:event_id])
    @bar = Bar.new(bar_params)
    @bar.event = @event
    if @bar.save
      redirect_to event_bars_path(@event)
    else
      render :index
    end
  end

  def new
    @event = Event.find(params[:event_id])
    @bar = Bar.new
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :address, :rating, :place_id)
  end

  def get_bars_from_google(event)
    # renvoie une réponse de google avec des bars à proximité du baeycentre
    # filtre ces bars selon ton call cad + 4.5 & open quand ça se passe
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=bar&type=bar&location=#{event.barycenter_lat},#{event.barycenter_lng}&radius=1500&key=AIzaSyDSooLIe1ubabNJ-sLiWwDaxN5JAHlkNn4")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    data = JSON.parse(response.read_body)
    bar_list = []
    # pour chacun de ces bars, tu récupères la place id & tu t'en sers pour un second call si nécessaire
      # Extraire le nom, la note et l'adresse`
    data["results"][0..5].each do |bar|
      photo_url = URI("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{bar["photos"][0]["photo_reference"]}&key=AIzaSyDSooLIe1ubabNJ-sLiWwDaxN5JAHlkNn4")
      new_bar = Bar.create({
        name: bar["name"],
        rating: bar["rating"],
        address: bar["vicinity"],
        placeid: bar["place_id"],
        photo: photo_url,
        event_id: event.id,
        latitude: bar["geometry"]["location"]["lat"],
        longitude: bar["geometry"]["location"]["lng"]
      })
      bar_list << new_bar
    end
    return bar_list
  end
end
