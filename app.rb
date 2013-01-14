require "rubygems"
require "bundler"
require 'net/http'
require 'uri'
Bundler.require :default, (ENV['RACK_ENV'] || "development").to_sym
BASE_HOST = "api.twitter.com"

CACHE_SECONDS = 1800 # 30 mins

get %r{/(.+)} do
  p "Incoming path: #{request.fullpath}"
  url = "#{BASE_HOST}#{request.fullpath}"
  p "Forward url: #{url}"
  page_string = nil
  response = Net::HTTP.get_response(BASE_HOST,request.fullpath)
  page_string = response.body
  content_type "application/json"
  cache_control :public, max_age: CACHE_SECONDS
  page_string
end
