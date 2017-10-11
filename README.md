# Gramscraper [![Gem Version](https://badge.fury.io/rb/gramscraper.svg)](https://badge.fury.io/rb/gramscraper) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
A simple instagram scraping gem which retrieves all your photos from instagram.

## Install
```ruby
gem install httparty
gem install gramscraper
```
or in Gemfile
```ruby
gem 'httparty'
gem 'gramscraper'
```

## Basic Usage
```ruby
require('gramscraper')

# Change this to your instagram username
instagram_username = "goproglenn"

# Retrieve instagram photos as array
photos = Gramscraper.scrape(instagram_username)
```

## Retrieving latest instagram post
Posts are sorted from newest to oldest so index 0 is the latest post.
```ruby
image_standard_res = photos.first[:standard_resolution]
image_low_res = photos.first[:low_resolution]
image_thumbnail = photos.first[:thumbnail]
image_caption = photos.first[:caption]
```

## Looping through every post
```ruby
photos.each do |photo|
    image_standard_res = photo[:standard_resolution]
    image_low_res = photo[:low_resolution]
    image_thumbnail = photo[:thumbnail]
    image_caption = photo[:caption]
end
```

## Rails (erb)
```ruby
<% photos.each do |photo| =>
    <%= image_tag photo[:standard_resolution] %>
    <%= image_tag photo[:low_resolution] %>
    <%= image_tag photo[:thumbnail] %>
    <p><%= photo[:caption] %></p>
<% end %>
```