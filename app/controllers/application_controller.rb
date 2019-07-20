
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/articles/new' do
    #binding.pry
    erb :new
  end

  get '/articles' do
    # binding.pry
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    #binding.pry
    Article.create(title: params["title"], content: params["content"])
    @articles = Article.all
    erb :index
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles/:id' do
    #binding.pry
    @article = Article.find(params[:id])
    erb :show
  end

  patch '/articles/:id' do
    #binding.pry
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    #binding.pry
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  delete '/articles/:id' do
    #binding.pry
    article = Article.find(params[:id])
    article.delete
    redirect '/articles'
  end
end
