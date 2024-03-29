class SessionsController < ApplicationController
def new
  render 'sessions/new'
end

  def create
      user = User.find_by(email: params[:session][:email].downcase)

        if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_to user_path(user)
        else
          flash.now[:danger] = 'Invalid email/password combination'
          redirect_to root_url
        end
  rescue StandardError => e
    flash.now[:danger] = "An error occurred: #{e.message}"
    redirect_to root_url
  end
end

  def destroy
    log_out
    redirect_to root_url
  end
