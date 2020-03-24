require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag.rb')
also_reload('../models/*')

get '/tags' do #index
  @tags = Tag.all()
  erb (:"tags/index")
end

get '/tags/new' do # new
  erb( :"tags/new" )
end

get '/tags/:id' do #show
  @tag = Tag.find(params['id'].to_i)
  erb( :"tags/show" )
end

get '/tags/:id/edit' do #edit
  @tag = Tag.find(params[:id].to_i)
  erb(:"tags/edit")
end

post '/tags/:id' do #update
  tag = Tag.new(params)
  tag.update()
  redirect to "/tags/#{params['id']}"
end

post '/tags' do #create
  tag = Tag.new(params)
  tag.save
  redirect to ('/tags')
end

post '/tags/:id/delete' do
  Tag.find(params['id'].to_i).delete()
  redirect to '/tags'
end
