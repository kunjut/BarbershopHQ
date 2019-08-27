#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
	@c = Client.new params[:client]
	@clients = Client.order "created_at DESC"
end

get '/' do
	erb :index			
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber	
end

get '/bookings' do
	erb :bookings			
end

get '/client/:id' do
	@client = Client.find(params[:id])
	erb :client
end

get '/visit' do
	@title = 'Запись'
	erb :visit
end

post '/visit' do

	if @c.save
		erb "<h2>Вы записались</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
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