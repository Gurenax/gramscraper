require 'httparty'

# Gramscraper
class Gramscraper
  def self.scrape(access_token, username="self")
    # Base URL for instagram media
    base_url = "https://api.instagram.com/v1/users/#{username}/media/recent/?access_token=#{access_token}"

    # Initialise the url (without max_id token)
    url = base_url

    # Initialise instagram array
    instagram = []

    # Use HTTParty to retrieve the JSON response
    page = HTTParty.get(url).parsed_response

    # Reset last_id
    last_id = ''
    page['data'].each do |page_item|
      # Post ID
      last_id = page_item['id']

      # Image Caption
      caption = page_item['caption']['text'] unless page_item['caption'].nil?

      # Get images in every resolution available
      unless page_item['images'].nil?
        thumbnail = page_item['images']['thumbnail']['url']
        low_resolution = page_item['images']['low_resolution']['url']
        standard_resolution = page_item['images']['standard_resolution']['url']
      end

      # Copy data to hash
      instagram_item = {
        last_id: last_id,
        caption: caption,
        thumbnail: thumbnail,
        low_resolution: low_resolution,
        standard_resolution: standard_resolution,
      }

      # Add instagram item hash to array
      instagram << instagram_item
    end
    instagram
  end
end
