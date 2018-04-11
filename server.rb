require 'sinatra'
require 'sinatra/activerecord'
require "pry" if development? || test?
require 'sinatra/flash'
set :sessions, true


Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
end

configure do
  set :views, 'app/views'
end

get '/' do
  redirect '/floofs'
end

get '/floofs' do
  @floofs = Floof.all

  erb :'/floofs/index'
end

get '/floofs/new' do
  erb :'floofs/new'
end

get '/floofs/:floof_id' do
  @floof = Floof.find(params[:floof_id])
  @walkers = Walker.all
  @walks = @floof.walks
  @days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  erb :'/floofs/show'
end

post '/walks' do
  @floof = Floof.find(params[:floof_id])
  @walker = Walker.find(params[:walker_id])
  @day = params[:day_id]
  walk = Walk.new(floof: @floof, walker: @walker, day: @day)

  if walk.save
    redirect "/floofs/#{params[:floof_id]}"
  else
    erb :'floofs/show'
  end
end

post '/floofs' do
  floof = Floof.new(name: params[:name])
    if floof.save
      flash.merge!(message: "Saved!")
      redirect "/floofs"
    else
      erb :'floofs/new'
    end
  erb :'floofs/index'
end

get '/walkers' do
  @walkers = Walker.all

  erb :'/walkers/index'
end

get '/walkers/new' do
  erb :'walkers/new'
end

get '/walkers/:walker_id' do
  @walker = Walker.find(params[:walker_id])
  @walks = @walker.walks
  @days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  erb :'/walkers/show'
end


post '/walkers' do
  walker = Walker.new(name: params[:name])
    if walker.valid?
      walker.save
      redirect '/walkers'
    else
      erb :'walkers/new'
    end
  erb :'walkers/new'
end
