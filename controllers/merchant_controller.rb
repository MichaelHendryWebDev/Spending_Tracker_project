require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')
also_reload('../models/*')

get '/merchant' do
  @merchant = Merchant.all()
  erb (:"merchant/index")
end

get '/merchant/:id' do
  @merchant = Merchant.find(params['id'].to_i)
  erb(":merchant/show")
end
