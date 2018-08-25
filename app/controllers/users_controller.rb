class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect  :"/tweets"
    else
      erb :"/users/create_user", locals: {message: "Please sign up before you sign in"}
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect :"/signup", locals: {message: "Please enter all required fields"}
    else
      @user = User.create(params)
      session[:user_id] = @user.id
        redirect :"/tweets"
    end

  end

  get '/login' do
    if logged_in?
      redirect :"/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:usr_id] = @user.id
      redirect :"/tweets"
    else
      redirect :"/signup"
    end
  end




end
