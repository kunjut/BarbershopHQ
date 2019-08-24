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
	@name = params[:username]
	@phone = params[:phonenumber]
	@datestamp = params[:datetime]
	@barber = params[:master]
	@color = params[:colorpicker]

	hh = {
		:name => @name, 
		:phone => @phone,	
		:datestamp => @datestamp, 
		:barber => @barber, 
		:color => @color
	}
	Client.create hh 

	erb "<h2>Вы записались</h2>"
end 