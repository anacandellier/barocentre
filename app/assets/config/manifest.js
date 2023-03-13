//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_tree ../builds
//= link manifest.json
{
  "background_color": "white",
  "description": ""
  "display": "fullscreen",
  "name": "Barocentre",
  "icons": [
    <% files = Dir.entries(Rails.root.join("app/assets/images/icons/")).select {|f| !File.directory? f} %>
    <% files.each_with_index do |file, index| %>
      <% match = file.match(/.+-(?<size>\d{2,3}x\d{2,3}).png/) %>
      {
        "src": "<%= image_path "icons/#{file}" %>",
        "sizes": "<%= match && match[:size] %>",
        "type": "image/png"
      }<%= "," unless (files.size - 1) == index %>
    <% end %>
  ]
}
