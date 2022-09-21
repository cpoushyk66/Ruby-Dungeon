class CharactersController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        characters = Character.all
        render json: characters, status: :ok
    end

    def show
        character = find_character
        render json: character, status: :ok
    end

    def create
        character = Character.create!(character_params)
        render json: character, status: :created
    end

    def update
        character = find_character
        character.update!(character_params)
        render json: character, status: :accepted
    end

    def destroy
        character = find_character
        character.destroy
        head :no_content
    end
    
    private


    def find_character
        Character.find(params[:id])
    end

    def character_params
        params.permit(:name, :title, :xp, :klass, :strength, :dexterity, :intelligence, :wisdom, :charisma, :constitution, :gold, :user_id)
    end

    def render_not_found_response
        render json: {error: "Character not found"}, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end
end
