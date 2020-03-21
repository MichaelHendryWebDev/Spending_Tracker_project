require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
also_reload('../models/*')

get '/transactions' do
  @transactions = Transaction.all
  erb(:'transactions/index')
end
