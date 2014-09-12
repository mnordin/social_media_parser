require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Facebook < Base
      URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/[\w\-]*)?(?:[?\d\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-\.]*)?/i

      def provider
        'facebook'
      end

      private

      def parse_username_from_url
        URL_REGEX.match(url_from_attributes).to_a[1]
      end
    end
  end
end
