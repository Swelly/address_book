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
sql = "select first from contacts"
#execute data base iteration. Return keys + values into contacts
db.exec(sql) do |result|
  result.each do |row|
    @contacts << row
  end
end
db.close
erb :index
end

#individual contacts by first name
#use phils' class example
get '/:first' do
  @first = params[:first]
  @contact_info = []
  db = PG.connect(:dbname => 'address_book',
                  :host => 'localhost')
  @contact = db.exec(
    "SELECT * FROM contacts WHERE first = '#{@first}' ").first
  db.close
  erb :contact_info
end

#get info from form on entry.erb
get '/contact/new_contact' do
  erb :entry
end

#post the GET info into address book database
post '/new_contact' do
#set instance variables to form entry
  @first = params[:first]
  @last = params[:last]
  @age = params[:age].to_i
  @gender = params[:gender]
  @dtgd = params[:dtgd]
  @phone = params[:phone]
#Use code from earlier DB entry
  db = PG.connect(:dbname => 'address_book',
                  :host => 'localhost')
  db.exec("INSERT INTO contacts (first, last, age, gender, dtgd, phone) values ('#{@first}', '#{@last}', #{@age}, '#{@gender}', #{@dtgd}, '#{@phone}')")
  db.close
  #Close and redirect to index (my addresses)
  redirect to('/')
end
