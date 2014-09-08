class SessionsController < ApplicationController
  layout 'signup'
  def new
    
  end

def create
  if params[:provider]=='facebook' || params[:provider]=='twitter'
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to projects_url, :notice => "Signed in!"
  else
    user = User.authenticate(params[:email],params[:password])
    if user
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      session[:user_id] = user.id
      redirect_to projects_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
end

def logout
  session[:user_id]=nil
  cookies.delete(:auth_token)
  redirect_to :action=>'new'
end

def destroy
  cookies.delete(:auth_token)
  redirect_to root_url, :notice => "Logged out!"
end
end
