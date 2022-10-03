class Enemy < ApplicationRecord

    has_many :pockets, as: :holder, dependent: :destroy
    has_many :items, through: :pockets
    has_many :spellslots, as: :caster, dependent: :destroy
    has_many :spells, through: :spellslots
    has_many :equipment, as: :wearer, dependent: :destroy

    def self.get_enemies(num)
        Enemy.all.sample(num)
    end


end
