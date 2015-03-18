require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Youtube < Base
      URL_REGEX = /\A(?:(?:http|https):\/\/)?(?:www.)?youtube\.com\/(?!channel|playlist)(?:user\/|)([\w\-\.]{1,})/i

      def url
        "https://www.youtube.com/user/#{username}"
      end

      private

      def extract_username_from_url
        URL_REGEX.match(extract_url_from_attributes).to_a[1]
      end
    end
  end
end
