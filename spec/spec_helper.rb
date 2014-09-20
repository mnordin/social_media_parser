require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$:.push File.expand_path("../lib", __FILE__)

require 'social_media_parser'
require 'public_suffix'
require 'pry'
