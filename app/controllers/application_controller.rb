
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  # INDEX: The controller action responds to a GET request to the route '/articles'. This action is the index action 
  # and allows the view to access all the articles in the database through the instance variable @articles.
  get '/articles' do
    @articles = Article.all
    erb :index 
  end

  # NEW: GET request to load the form to create a new article
  get '/articles/new' do
    @article = Article.new 
    erb :new
  end 

  # CREATE action: This action responds to a POST request and creates a new article based on the params 
  # from the form and saves it to the database. Once the item is created, this action redirects to the show page
  post '/articles' do
    @article = Article.create(params)
    redirect to "/articles/#{@article.id}"
  end 

  # SHOW: This (show action) controller action responds to a GET request to the route '/articles/:id'. 
  # Because this route uses a dynamic URL, we can access the ID of the article in the view through the params hash.
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end 

  # EDIT: loads the edit form in the browser by making a GET request to articles/:id/edit
  get '/articles/:id/edit' do 
    @article = Article.find_by_id(params[:id])
    erb :edit
  end
 
  # UPDATE: handles the edit form submission; this action responds to a PATCH request to the route /articles/:id 
  # First, we pull the article by the ID from the URL, then we update the title and content attributes and save. 
  # The action ends with a redirect to the article show page.
  patch '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  # DELETE: The form is submitted via a DELETE request to the route /articles/:id. This action finds the article in 
  # the database based on the ID in the url parameters, and deletes it. It then redirects to the index page /articles.
  delete '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.delete
    redirect to '/articles'
  end

end
