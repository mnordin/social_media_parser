require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Facebook < Base
      URL_REGEX = /\A(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/[\w\-]*)?(?:[?\d\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-\.]*)?/i

      private

      def extract_username_from_url
        URL_REGEX.match(extract_url_from_attributes).to_a[1]
      end
    end
  end
end
