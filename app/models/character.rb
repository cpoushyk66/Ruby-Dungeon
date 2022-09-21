class Character < ApplicationRecord

    belongs_to :user
    has_many :pockets, as: :holder, dependent: :destroy
    has_many :items, through: :pockets
    has_many :spellslots, as: :caster, dependent: :destroy
    has_many :spells, through: :spellslots


    def initialize
        @max_pockets = self.strength * 2
    end

    def learn_spell(spell)
        if (self.spells.include?(spell))
            Spellslot.create(spell_id: spell.id, caster: self) 
        else
            puts "Already know spell!"
        end
    end

    def pick_up_item(item)
        if (self.pockets.count < @max_pockets)
            Pocket.create(item_id: item.id, holder: self)
        else
            puts "Pockets full!"
        end
    end

end
