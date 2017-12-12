require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'
require './lib/link'

class Bookmark < Sinatra::Base

  get '/home' do
    @links = Link.all
    erb(:home)
  end

end
