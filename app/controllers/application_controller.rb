
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
     set :method_override, true
  end

  get '/' do
    "Welcome"
  end

  #READ -- try moving this to under create once done.
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  #CREATE
  get '/articles/new' do
    erb :new
  end

 post '/articles' do
   @article = Article.create(title: params[:title],content: params[:content])
   redirect "/articles/#{@article.id}"
 end

 #READ
 get '/articles/:id' do
  @article = Article.find(params[:id])
  erb :show
end

#UPDATE
 get '/articles/:id/edit' do
   @article = Article.find(params[:id])
   erb :edit
 end

 patch '/articles/:id' do
   @article = Article.find(params[:id])
   @article.title = params[:title]
   @article.content = params[:content]
   @article.save
   redirect to "/articles/#{@article.id}"
 end


#DELETE
 delete '/articles/:id/delete' do
   @article = Article.find(params[:id])
   @article.delete
   redirect '/articles'
 end

end
