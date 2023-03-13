class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :invite ]


  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def invite
    @event = Event.find(params[:id])
  end

  def choose_bar
    # nest la methode choose bar dans events afin de récupérer l'id de l'event
    # quand on clique sur choisir, aller sur la route "choose", et passer en argument dans l'url l'ID du bar
    # stocker l'id du bar dans 'selected_bar_id' de l'event`
    @bar = Bar.find(params[:bar])
    @bar.update(selected: true)
    # sauvegarder l'event
    # et redirifer sur la page itinéraire
    redirect_to event_itineraire_path(Event.find(params[:event_id]))
  end

  def itineraire
    @event = Event.find(params[:event_id])
    @bar = @event.selected_bar
    @event_users = @event.event_users
  end

  def show
    @event = Event.find(params[:id])
  end

  def share
    @event = Event.find(params[:id])
  end


  private

  def event_params
    params.require(:event).permit(:name, :date)
  end

end
