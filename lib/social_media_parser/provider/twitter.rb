require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Twitter < Base
      URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?twitter.com\/(?:(?:\w)*#!\/)?(\w*)/i

      def provider
        'twitter'
      end

      private

      def extract_username_from_url
        URL_REGEX.match(extract_url_from_attributes).to_a[1]
      end
    end
  end
end
