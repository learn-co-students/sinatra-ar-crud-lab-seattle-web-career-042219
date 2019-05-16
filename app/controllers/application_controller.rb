require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
  	redirect "/articles"
  end

  get "/articles" do
  	@articles = Article.all
  	erb :index
  end

  get "/articles/new" do
  	@article = Article.new
  	erb :new
  end

  get "/articles/:id" do
  	@article = Article.find(params[:id])
  	erb :show
  end

  post "/articles" do
  	@article = Article.create(title: params[:title], content: params[:content])
  	redirect to "/articles/#{@article.id}"
  end

  get "/articles/:id/edit" do
  	@article = Article.find(params[:id])
  	erb :edit
  end

  patch "/articles/:id" do
  	@article = Article.find(params[:id])
  	@article.update(title: params[:title], content: params[:content])
  	redirect to "/articles/#{@article.id}"
  end

  delete "/articles/:id" do
  	Article.destroy(params[:id])
  	redirect to "/articles"
  end

  delete "/articles" do
  	Article.destroy_all
  	ActiveRecord::Base.connection.execute("UPDATE sqlite_sequence SET seq = 0 WHERE name = 'articles'")
  	redirect to "/articles"
  end
end
