class SessionsController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: "Login successful" }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end


  def logout
    return if session[:user_id].nil?
    # Clear the session
    session[:user_id] = nil
    render json: { message: "Logout successful" }, status: :ok
  end
end
