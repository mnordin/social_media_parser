require 'spec_helper'

describe SocialMediaParser do
  let(:parser){ described_class.parse profile_attributes }

  context "correct class" do
    let(:profile_attributes) { {url: "https://www.linkedin.com/in/conanobrien"} }

    it "returns a Linkedin object" do
      expect(parser).to be_a SocialMediaParser::Provider::Linkedin
    end
  end

  context "with linkedin as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "conanobrien", provider: "linkedin"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.linkedin.com/in/conanobrien"
      expect(parser.provider).to eq "linkedin"
      expect(parser.username).to eq "conanobrien"
    end
  end

  context "with linkedin as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "www.linkedin.com/in/williamhgates", provider: "linkedin"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.linkedin.com/in/williamhgates"
      expect(parser.provider).to eq "linkedin"
      expect(parser.username).to eq "williamhgates"
    end
  end

  context "with linkedin url and provider" do
    let(:profile_attributes){ {url: "http://linkedin.com/in/barackobama", provider: "linkedin"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.linkedin.com/in/barackobama"
      expect(parser.provider).to eq "linkedin"
      expect(parser.username).to eq "barackobama"
    end
  end

  context "url variations" do
    it "parses username from url without trailing slash" do
      parser = described_class.parse "http://linkedin.com/in/barackobama"
      expect(parser.username).to eq "barackobama"
    end

    it "parses username from url with www" do
      parser = described_class.parse "http://linkedin.com/in/conanobrien/"
      expect(parser.username).to eq "conanobrien"
    end

    it "parses username from url without http" do
      parser = described_class.parse "linkedin.com/in/williamhgates/"
      expect(parser.username).to eq "williamhgates"
    end

    it "parses username from country subdomain urls without http" do
      parser = described_class.parse "se.linkedin.com/in/markusnordin"
      expect(parser.username).to eq "markusnordin"
    end

    it "parses username from country subdomain urls with http" do
      parser = described_class.parse "http://se.linkedin.com/in/markusnordin"
      expect(parser.username).to eq "markusnordin"
    end

    it "doesn't parse old public profile urls" do
      parser = described_class.parse "www.linkedin.com/pub/cameron-diaz/6b/328/111"
      expect(parser.username).to eq nil
      expect(parser).to be_a SocialMediaParser::Link
    end

    it "doesn't parse old public profile urls with country subdomain" do
      parser = described_class.parse "ua.linkedin.com/pub/mila-kunis/55/4a2/3b5/en"
      expect(parser.username).to eq nil
      expect(parser).to be_a SocialMediaParser::Link
    end
  end
end
