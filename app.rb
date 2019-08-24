#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index			
end

get '/visit' do
	@title = 'Записаться'
	erb :visit
end

post '/visit' do
	@title = 'Записаться'
	@username = params[:username]
	@phonenumber = params[:phonenumber]
	@datetime = params[:datetime]
	@master = params[:master]
	@colorpicker = params[:colorpicker]

	erb "<h2>Вы записались</h2>"
end