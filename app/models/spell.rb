class Spell < ApplicationRecord

    has_many :spellslots, dependent: :destroy
    has_many :characters, thorugh: :spellslots
    has_many :enemies, through: :spellslots


end
