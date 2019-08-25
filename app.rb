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

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index			
end

get '/visit' do
	@title = 'Запись'
	erb :visit
end

post '/visit' do
	
	c = Clients.new params[:client]
	c.save

	erb "<h2>Вы записались</h2>"
end 

get '/contacts' do
	@title = 'Контакты'
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@message = params[:message]

	hh = {
		:email => @email, 
		:message => @message	
	}
	Contact.create hh 

	erb "<h2>Ваше сообщение отправлено</h2>"
end