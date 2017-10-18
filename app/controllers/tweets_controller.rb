class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      @user = current_user
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      @user = current_user
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = current_user
    if logged_in? && !params[:content].empty?
    @tweets = Tweet.create(content: params[:content])
    @user.tweets << @tweets
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  #post '/tweets/:id/edit' do
  #@tweet = Tweet.find_by_id(params[:id])
  #@tweet.content = params[:content]
  #@tweet.save
  #redirect to "/tweets/#{@tweet.id}"
  #end


  delete 'tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.delete
    redirect to '/tweets'
  end



end
