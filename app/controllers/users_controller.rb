class UsersController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        users = User.all
        render json: users, status: :ok
    end

    def show
        user = find_user
        render json: user, except: [:id, :created_at, :updated_at], status: :ok
    end

    def create
        user = User.create!(user_params)
        render json: user, status: :created
    end

    def update
        user = find_user
        user.update!(user_params)
        render json: user, status: :accepted
    end

    def destroy
        user = find_user
        user.destroy
        head :no_content
    end

    def login
        user = User.find("username = ? AND password = ?", params[:username], params[:password])
        render json: user, status: :accepted
    end

    def give_admin_access
        admin = find(params[:admin_id])
        user = find(params[:user_id])
        if (User.give_admin_access(admin, user))
            render json: user, status: :accepted
        else
            render json: {error: "Unauthorized Action!"}, status: :unauthorized
        end
    end

    def characters
        user = find_user
        characters = user.characters
        render json: characters, status: :ok
    end
    
    private

    def find_user
        User.find(params[:id])
    end

    def user_params
        params.permit(:username, :password, :image, :dark_mode)
    end

    def render_not_found_response
        render json: {error: "User not found"}, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end
end
