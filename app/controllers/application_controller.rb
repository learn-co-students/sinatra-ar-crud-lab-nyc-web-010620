
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
    article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{article.id}"
  end

  get '/articles/:id' do 
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do 
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do 
    article = Article.find_by_id(params[:id])
    article.update(title: params[:title],content: params[:content])
    redirect to "/articles/#{article.id}"
  end

  delete '/articles/:id' do 
    @article = Article.find_by_id(params[:id])
    @article.destroy
    redirect to "/articles"
  end
end

