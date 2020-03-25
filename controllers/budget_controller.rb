require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/budget.rb')
also_reload('../models/*')

get '/budgets' do   #index
  @budgets = Budget.all
  erb (:"budgets/index")
end

get '/budgets/new' do # new
  erb( :"budgets/new" )
end

get '/budgets/:id' do #show
  @budget =  Budget.find(params['id'].to_i)
  erb(:"budgets/show")
end


get '/budgets/:id/edit' do #edit
  @budget = Budget.find(params[:id].to_i)
  erb(:"budgets/edit")
end

post '/budgets/:id' do
  budget = Budget.new(params)
  budget.update()
  redirect to "/budgets/#{params['id']}"
end

post '/budgets' do #create
  budget = Budget.new(params)
  budget.save()
  redirect to ('/budgets')
end
