module TranslateHelper
  def translate(word)
    case word
    when "created"
      "Evénement créé"
    when "open"
      "Invités en cours d'ajout"
    when "vote"
      "Votes en cours"
    when "closed"
      "Bar O Centre !"
    when "transit"
      "Transports en commun"
    when "driving"
      "Voiture"
    when "bicycling"
      "Vélo"
    end
  end
end
