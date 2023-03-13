require "uri"
require "net/http"

class BarsController < ApplicationController
  def index

    @event = Event.find(params[:event_id])
    get_bars_from_google(@event)
    @bars = Bar.where(event_id: params[:event_id])
    @markers = @bars.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {bar: bar}),
        marker_html: render_to_string(partial: "marker", locals: {bar: bar})
      }
     end


  end

  def map
    @event = Event.find(params[:event_id])
    @bars = Bar.where(event_id: params[:event_id])
    @markers = @bars.map do |bar|votes
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {bar: bar}),
          marker_html: render_to_string(partial: "marker", locals: {bar: bar})
      }
    end
    @barycenter_marker = [{
      lat: @event.barycenter_lat,
      lng: @event.barycenter_lng,
      marker_html: render_to_string(partial: "marker")
    }]
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

  def classment
    @event = Event.find(params[:event_id])
    @event_users = Event.find(params[:event_id]).event_users
    @bars = Bar.where(event_id: params[:event_id]).sort { |a, b| b.votes.count <=> a.votes.count }
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :address, :rating, :place_id)
  end

  def get_bars_from_google(event)
    # renvoie une réponse de google avec des bars à proximité du baeycentre
    # filtre ces bars selon ton call cad + 4.5 & open quand ça se passe
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=bar&type=bar&location=#{event.barycenter_lat},#{event.barycenter_lng}&radius=500&key=#{ENV['GOOGLE_API_KEY']}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    data = JSON.parse(response.read_body)
    # pour chacun de ces bars, tu récupères la place id & tu t'en sers pour un second call si nécessaire
    # Extraire le nom, la note et l'adresse`
    counter = 0
    data["results"]&.each do |bar|
      photo_url = URI("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{bar["photos"]&.first&.dig("photo_reference")}&key=#{ENV['GOOGLE_API_KEY']}")
      new_bar = Bar.create(
        name: bar["name"],
        rating: bar["rating"],
        address: bar["vicinity"],
        placeid: bar["place_id"],
        photo: photo_url,
        event: event,
        latitude: bar.dig("geometry", "location", "lat"),
        longitude: bar.dig("geometry", "location", "lng")
      )
      counter += 1 unless new_bar.nil?
      break if counter >= 5
    end
    # end
  end
end
