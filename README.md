# Gramscraper [![Gem Version](https://badge.fury.io/rb/gramscraper.svg)](https://badge.fury.io/rb/gramscraper) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
A simple gem to retrieve your recent photos from your Instagram.

## Major update (v1.0.1)
- Instagram no longer supports the public media endpoint (https://instagram.com/username/media) which does not require an API client key or Access token.
- As such, I am forced to use the API (which is the right way to get the photos from your instagram account).
- Please note that to use this gem, you need to have a valid access token from instagram. The instructions can be found here (https://www.instagram.com/developer/authentication/). Look for Client-Side (Implicit) Authentication. It is what you need to get this gem working. However, to assist you in getting the access token, I will put some of my notes below anyway.

## Registering for an Instagram access token
1. Go to (https://www.instagram.com/developer/)
2. Click Register Your Application
3. Click Register a New Client
4. Specify all the details as much as possible but the most important thing is the "Valid redirect URIs".
5. For development purposes, just specify a http://localhost:3000 (Default rails server).
6. Click Register
7. Notice that your CLIENT STATUS is still in "Sandbox Mode". This is ok. All you need for now is to grab your own photos and you do not need to be in "Production Mode" to do that.
8. Once saved, copy the CLIENT ID token.
9. Open your browser and copy this URL but replace "CLIENT-ID" and "REDIRECT-URI".    
* Format:   
`https://api.instagram.com/oauth/authorize/?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=token`    
* Example:    
`https://api.instagram.com/oauth/authorize/?client_id=55555555555555555555&redirect_uri=http://localhost:3000&response_type=token`    
10. Whether or not you actually have localhost:3000 server started, once you open the url, the address will change to something like:   
* Format:   
`http://your-redirect-uri#access_token=ACCESS-TOKEN`    
* Example:    
`https://api.instagram.com/v1/media/username?access_token=1234567890`   
11. Copy the access_token (i.e. 1234567890) value and you're done!


## Installing the Gem
The only dependency of this project is HTTParty.

```ruby
gem install httparty
gem install gramscraper
```
or in your Gemfile
```ruby
gem 'httparty'
gem 'gramscraper'
```

## Basic Usage
Using gramscraper is simple, just follow the instructions below.

```ruby
require('gramscraper')

# Change this to your access token. Please see instructions above on how to get this access token.
access_token = "1234567890"

# Change this to your instagram username
instagram_username = "goproglenn"

# Retrieve instagram photos as array
# (For ruby, just run the method like so)
# (For rails, this can be placed in your model or controller)
photos = Gramscraper.scrape(access_token, instagram_username)
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

## Rails (in your erb file)
```ruby
<% photos.each do |photo| %>
  <%= image_tag photo[:standard_resolution] %>
  <%= image_tag photo[:low_resolution] %>
  <%= image_tag photo[:thumbnail] %>
  <p><%= photo[:caption] %></p>
<% end %>
```