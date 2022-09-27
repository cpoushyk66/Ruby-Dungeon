class Item < ApplicationRecord

    has_many :pockets, dependent: :destroy
    has_many :characters, through: :pockets
    has_many :enemies, through: :pockets
    
    def self.get_items(num)
        Item.all.sample(num).uniq
    end
end
