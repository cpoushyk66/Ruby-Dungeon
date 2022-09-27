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

    def characters
        characters = User.find(params[:id]).characters
        render json: characters, status: :ok
    end
    
    def shop
        character = find_character
        item = Item.find_by(id: params[:item_id])

        if (params[:shop_action] == "buy")
            character.buy_item(item)
            render json: character, staus: :accepted
        elsif (params[:shop_action] == "sell")
            character.sell_item(item)
            render json: character, staus: :accepted
        else
            render json: {error: "Invalid Action!"}, status: :unauthorized
        end
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