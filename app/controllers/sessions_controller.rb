class SessionsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def create
        user = User.find_by(username: params[:username])
        if (user && user.password == params[:password])
            session[:user_id] = user.id
            render json: user
        elsif (user)
            render json: {error: "Incorrect Password!"}, status: :unauthorized
        else
            render json: {error: "No user found with that username!"}, status: :not_found
        end
    end

    def destroy
        session.delete :user_id
        head :no_content
      end

    private
    
    def render_not_found_response
        render json: {error: "User not found"}, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end
  end