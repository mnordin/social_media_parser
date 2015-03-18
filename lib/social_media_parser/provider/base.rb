require 'social_media_parser/link'
require 'uri'

module SocialMediaParser
  module Provider
    class Base < ::SocialMediaParser::Link
      def self.parse(attributes)
        providers.map do |provider|
          SocialMediaParser::Provider.const_get(provider.capitalize).new(attributes)
        end.find(&:match?) or ::SocialMediaParser::Link.new(attributes)
      end

      def username
        return @username if @username

        if @url_or_username and not_a_url? @url_or_username
          @url_or_username
        elsif extract_url_from_attributes
          extract_username_from_url
        end
      end

      def url
        extract_url_from_attributes || "https://www.#{provider}.com/#{username}"
      end

      def match?
        (@provider and @provider.downcase == provider) or
        URI.parse(extract_url_from_attributes).host.match("#{provider}.com")
      rescue URI::BadURIError, URI::InvalidURIError
        false
      end

      private

      # Common social media url format, like http(s)://(www.)[provider].com/[username]
      # Overwrite this in subclasses when url formatting is different
      def extract_username_from_url
        URI.parse(extract_url_from_attributes).path.split("/")[1]
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
