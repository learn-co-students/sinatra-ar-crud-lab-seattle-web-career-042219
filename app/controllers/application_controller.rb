
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.destroy
    redirect "/articles"
  end
end
