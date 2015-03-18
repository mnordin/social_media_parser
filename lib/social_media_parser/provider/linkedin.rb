require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Linkedin < Base
      URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.|[a-z]{2}.)?linkedin.com\/in\/([\w]*)/i

      def url
        "https://www.linkedin.com/in/#{username}"
      end

      private

      def extract_username_from_url
        URL_REGEX.match(extract_url_from_attributes).to_a[1]
      end
    end
  end
end
