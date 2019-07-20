
require_relative '../../config/environment'
class ApplicationController < Sinatra::Base

require 'byebug'
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @article = Article.all
    erb :index
  end

  get '/articles' do
    @article = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    Article.create(:title => params[:title], :content => params[:content])
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit'do
  @article = Article.find(params[:id])
  erb :edit
  end

  patch '/articles/:id' do
   article = Article.find(params[:id])
   article.update_attributes(:content =>params[:content], :title =>params[:title])
   redirect "/articles/#{article.id}"
  end

  delete '/articles/:id' do

  Article.delete(params[:id])
  erb :index

  end

end
