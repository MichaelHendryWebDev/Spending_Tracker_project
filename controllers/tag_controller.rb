require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag.rb')
also_reload('../models/*')

get '/tags' do
  @tags = Tag.all()
  erb (:"tags/index")
end

get '/tags/:id' do
  @tag = Tag.find(params['id'].to_i)
  erb( :"tags/show" )
end

get '/tags/:id/create' do
  @tag = Tag.find(params[:id].to_i)
  erb(:"tags/create")
end

post '/tags' do
  tag = Tag.new(params)
  tag.save
  redirect to (:"/tags")
end

post '/tags/:id/delete' do
  Tag.find(params['id'].to_i).delete()
  redirect to '/tags'
end
