class DungeonController < ApplicationController

    def generate_dungeon
        dungeon = Dungeon.generate_dungeon(params[:num].to_i)
        render json: dungeon
    end

end
