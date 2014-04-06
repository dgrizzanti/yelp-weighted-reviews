require 'oauth'
require 'json'

class WelcomeController < ApplicationController
  attr_accessor :restaurants

  def index
    search_yelp(params)
    @restaurants ||= {}
  end

  def search_yelp(params)
    return unless params[:city]
    consumer_key = 'yWsf9YoPuTep7cI3XpZNHA'
    consumer_secret = '6BmQxm1DaooBZUwD85gf2wUpoMk'
    token = 'GCE9LhO-Ip2HV6fo7OLbNbvq9xrGUOnM'
    token_secret = 'uq0iGMRDujizlovmtA9scGamMns'

    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)

    city = "location=#{params[:city]}" unless params[:city].blank?
    category = "category_filter=#{params[:category]}" unless params[:category].blank?
    term = "term=#{params[:term]}" unless params[:term].blank?
    path = "/v2/search?#{term}&#{city}&#{category}"

    @restaurants = JSON.parse(access_token.get(path).body)['businesses']
  end
end
