# use this code to create an address book in sinatra
# create an input form
# add a person
# list people
require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

db = PG.connect(:dbname => 'address_book',
  :host => 'localhost')

get '/' do
@contacts = []
#phils class example
db = PG.connect(:dbname => 'address_book',
                :host => 'localhost')
sql = "select first, age from contacts"
#execute data base iteration. Return keys + values into contacts
db.exec(sql) do |result|
  result.each do |row|
    @contacts << row
  end
end
db.close
erb :index
end
