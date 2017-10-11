require 'httparty'

class Gramscraper
    
    def self.scrape(username)
        # Base URL for instagram media
        base_url = "https://www.instagram.com/#{username}/media"

        # Initialise the url (without max_id token)
        url = base_url

        # Initialise instagram array
        instagram = Array.new

        while true    
            # Use HTTParty to retrieve the JSON response
            page = HTTParty.get(url).parsed_response

            # Reset last_id
            last_id = ""
            
            page["items"].each do |page_item|

                # Post ID
                last_id = page_item["id"]

                # Image Caption
                caption = page_item["caption"]["text"] unless page_item["caption"].nil?

                # Get images in every resolution available
                thumbnail = page_item["images"]["thumbnail"]["url"] unless page_item["images"].nil?
                low_resolution = page_item["images"]["low_resolution"]["url"] unless page_item["images"].nil?
                standard_resolution = page_item["images"]["standard_resolution"]["url"] unless page_item["images"].nil?

                # Copy data to hash
                instagram_item = {
                    :last_id => last_id, :caption => caption, :thumbnail => thumbnail, :low_resolution => low_resolution, :standard_resolution => standard_resolution,
                }

                # Add instagram item hash to array
                instagram << instagram_item
            end

            # If there are more photos to scraper, capture the last_id and use it as token to ?max_id=
            if page["more_available"]==true
                next_page_token = "/?max_id=#{last_id}"     # e.g. /?max_id=1537732482693479519_54429723
                url = base_url + next_page_token
            
            # Else there are no more photos so end the loop
            else
                break
            end
        end
        instagram
    end
end