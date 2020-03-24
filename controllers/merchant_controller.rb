require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')
also_reload('../models/*')

get '/merchants' do   #index
  @merchants = Merchant.all()
  erb (:"merchants/index")
end

get '/merchants/new' do # new
  erb( :"merchants/new" )
end

get '/merchants/:id' do #show
  @merchant =  Merchant.find(params['id'].to_i)
  erb(:"merchants/show")
end


get '/merchants/:id/edit' do #edit
  @merchant = Merchant.find(params[:id].to_i)
  erb(:"merchants/edit")
end

post '/merchants/:id' do
  merchant = Merchant.new(params)
  merchant.update()
  redirect to "/merchants/#{params['id']}"
end

post '/merchants' do #create
  merchant = Merchant.new(params)
  merchant.save
  redirect to ('/merchants')
end



post '/merchants/:id/delete' do #delete
  Merchant.find(params['id'].to_i).delete()
  redirect to '/merchants'
end
