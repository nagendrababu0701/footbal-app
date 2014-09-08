class UsersController < ApplicationController
  layout 'signup'
  	def new
  @user = User.new
end

def create
  @user = User.new(person_params)
  if @user.save
    redirect_to root_url, :notice => "Signed up!"
  else
    render "new"
  end
end

def person_params
    params.require(:user).permit(:email,:role,:first_name,:last_name,:notification,:password,:password_confirmation)
  end
end
