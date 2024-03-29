class PasswordResetsController < ApplicationController
	def index
		
	end
 def create
  user = User.find_by_email(params[:email])
  user.send_password_reset if user
  redirect_to root_url, :notice => "Email sent with password reset instructions."
end

def edit
  @user = User.find_by_password_reset_token!(params[:id])
end

def update
  @user = User.find_by_password_reset_token!(params[:id])
  if @user.password_reset_sent_at < 2.hours.ago
    redirect_to new_password_reset_path, :alert => "Password reset has expired."
  elsif @user.update_attributes(person_params)
    redirect_to root_url, :notice => "Password has been reset!"
  else
    render :edit
  end
end
def person_params
    params.require(:user).permit(:email,:role,:first_name,:last_name,:notification,:password,:password_confirmation)
  end
end
