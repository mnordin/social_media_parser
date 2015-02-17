require 'social_media_parser/link'
require 'uri'

module SocialMediaParser
  module Provider
    class Base < ::SocialMediaParser::Link
      def self.parse(attributes)
        providers.map do |provider|
          eval("SocialMediaParser::Provider::#{provider.capitalize}").new(attributes)
        end.find(&:valid?) or ::SocialMediaParser::Link.new(attributes)
      end

      def username
        return @username if @username
        if @url_or_username and invalid_url_format? @url_or_username
          @url_or_username
        elsif url_from_attributes
          parse_username_from_url
        end
      end

      def url
        return url_from_attributes if url_from_attributes
        "https://www.#{provider}.com/#{username}"
      end

      def valid?
        (@provider and @provider.downcase == provider) or
        (username and URI.parse(url_from_attributes).host.match("#{provider}.com"))
      rescue URI::BadURIError, URI::InvalidURIError
        false
      end

      private

      # Common social media url format, like http(s)://(www.)[provider].com/[username]
      # Overwrite this in subclasses when url formatting is different
      def parse_username_from_url
        URI.parse(url_from_attributes).path.split("/")[1]
      rescue URI::BadURIError, URI::InvalidURIError
        nil
      end

      # Does a file name lookup in the providers/ folder and outputs all file
      # names, except for this base file
      def self.providers
        @providers ||= Dir.entries(__dir__)
          .reject{|f| File.directory? f }.map{|s| s.gsub(".rb", "")} - ["base"]
      end
    end
  end
end
