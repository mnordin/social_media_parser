require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Google < Base
      URL_REGEX = /\A(?:(?:http|https):\/\/)plus.google.com\/?(?:u\/\d{1,}\/|)(?:\+|)([\w\-\.\%]{1,})/i

      # Google Plus urls prepends + for username based urls and without for id based
      def url
        return extract_url_from_attributes if extract_url_from_attributes

        if username
          url_username = is_i?(username) ? "+#{username}" : username
          "https://plus.google.com/#{url_username}"
        end
      end

      private

      def extract_username_from_url
        URL_REGEX.match(extract_url_from_attributes).to_a[1]
      end

      def is_i?(string)
        !string.match(/\A\d+\z/)
      end
    end
  end
end
