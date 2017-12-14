ENV['RACK_ENV'] ||= 'dev'

require 'sinatra/base'
require './datamapper_setup.rb'
require './lib/models/link'
require './lib/models/tag'

class Bookmark < Sinatra::Base

  get '/home' do
    @links = Link.all
    # @single = Link.get(9)
    # p @single
    erb(:home)
  end

  get '/addlink' do
    erb(:addlink)
  end

  post '/addedlink' do
    link = Link.create(url: params[:url], name: params[:name])
    tag = Tag.first_or_create(name: params[:tag])
    link.tag << tag
    link.save
    redirect '/home'
  end

  post '/search' do
    redirect "tags/#{params[:search_tag]}"
  end

  get "/tags/:search_tag" do
    tag = Tag.first(name: params[:search_tag])
    @links = (tag ? tag.link : [])
    erb(:searched)
  end

end
