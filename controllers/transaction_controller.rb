require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/budget.rb')
also_reload('../models/*')
require('pry-byebug')

get '/transactions' do #index
  @transactions = Transaction.all
  @total = Transaction.add_total(@transactions)
  erb(:'transactions/index')
end

get '/transactions/new' do
  @budgets = Budget.all
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

get '/transactions/:id' do
  @transaction =  Transaction.find(params['id'].to_i)
  erb(:"transactions/show")
end

get '/transactions/:id/edit' do
  @merchants = Merchant.all
  @tags = Tag.all
  @transaction = Transaction.find(params[:id].to_i)
  erb(:"transactions/edit")
end

post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to "/transactions/#{params['id']}"
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to ("/transactions")
end

post '/transactions/:id/delete' do #delete
  Transaction.find(params['id'].to_i).delete()
  redirect to '/transactions'
end
