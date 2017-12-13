ENV['RACK_ENV'] ||= 'dev'

require 'sinatra/base'
require './lib/models/link'

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
    Link.create(url: params[:url], name: params[:name])
    redirect '/home'
  end

end
