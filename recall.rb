# require 'rubygems'
require 'sqlite3'
require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.rb")

class Note
	include DataMapper::Resource
	property :id, Serial
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, :default => false
	property :created_at, DateTime
	property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
	# "Hello world!"
	@notes = Note.all :order => :id.desc
	@title = 'All Notes'
	erb :home	
end

post '/' do
	n = Note.new
	n.content = params[:content]
	n.created_at = Time.now
	n.updated_at = Time.now
	n.save
	redirect '/'
end



