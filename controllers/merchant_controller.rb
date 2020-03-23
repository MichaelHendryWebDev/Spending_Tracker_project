require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')
also_reload('../models/*')

get '/merchants' do
  @merchants = Merchant.all()
  erb (:"merchants/index")
end


get '/merchants/:id' do
  @merchant =  Merchant.find(params['id'].to_i)
  erb(:"merchants/show")
end

post '/merchants' do
  merchant = Merchant.new(params)
  merchant.save
  redirect to ("/merchants")
end

get '/merchants/:id/edit' do
  @merchant = Merchant.find(params[:id].to_i)
  erb(:"merchants/edit")
end

post '/merchants/:id' do
  Merchant.new(params).update()
  redirect to ("/merchants")
end

post '/merchants/:id/delete' do
  Merchant.find(params['id'].to_i).delete()
  redirect to '/merchants'
end
