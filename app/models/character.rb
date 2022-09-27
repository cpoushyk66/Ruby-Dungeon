class Character < ApplicationRecord

    belongs_to :user
    has_many :pockets, as: :holder, dependent: :destroy
    has_many :items, through: :pockets
    has_many :spellslots, as: :caster, dependent: :destroy
    has_many :spells, through: :spellslots


    def learn_spell(spell)
        if (self.spells.include?(spell))
            self.spellslots.create(spell_id: spell.id) 
        else
            puts "Already know spell!"
        end
    end

    def pick_up_item(item)
        self.pockets.create(item_id: item.id)
    end

    def buy_item(item)
        if (self.gold >= item.value)
            self.pick_up_item(item)
            self.update(gold: self.gold - item.value)
            true
        elsif (self.gold < item.value)
            puts "Too poor!"
            false
        end
    end

    def sell_item(item)
        pocket = Pocket.find_by(item_id: item.id, holder: self)
        if (pocket)
            pocket.destroy
            self.update(gold: self.gold + item.value)
            true
        else
            puts "Item not found"
            false
        end
    end           


end
