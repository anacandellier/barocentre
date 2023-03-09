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
    end
  end
end
