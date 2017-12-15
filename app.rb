ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require './datamapper_setup.rb'
require './lib/models/link'
require './lib/models/tag'
require './lib/models/user'

class Bookmark < Sinatra::Base

  enable :sessions
  set :session_secret, 'Sif'
  register Sinatra::Flash

  get '/sign_up' do
    erb(:sign_up)
  end

  post '/signed_up' do
    DataMapper.finalize
    DataMapper.auto_upgrade!
    user = User.create(email: params[:email], password: params[:password],
      password_confirmation: params[:confirm_password])
    if user.save
      session[:user_id] = user.id
      session[:email] = params[:email]
      redirect '/home'
    elsif
      flash.next[:errors] = user.errors.full_messages
      redirect '/sign_up'
    end
  end

  post '/logged_in' do
    user = User.first(email: params[:user_email])
    # redirect '/sign_up' if !user
    if (BCrypt::Password.new(user.password_digest) == params[:user_password])
      session[:user_id] = user.id
      session[:email] = user.email
      redirect '/home'
    else
      redirect '/sign_up'
    end
  end

  get '/home' do
    @links = Link.all
    @email = session[:email]
    # @single = Link.get(9)
    # p @single
    erb(:home)
  end

  get '/addlink' do
    erb(:addlink)
  end

  post '/addedlink' do
    link = Link.create(url: params[:url], name: params[:name])
    #tag = Tag.first_or_create(name: params[:tag])
    (params[:tag].split(', ')).each { |tagname|
      link.tag << Tag.first_or_create(name: tagname)
    }
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

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

end
