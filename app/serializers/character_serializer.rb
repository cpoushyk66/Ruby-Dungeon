class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :title, :xp, :klass, :strength, :dexterity, :wisdom, :charisma, :intelligence, :constitution, :gold, :user_id, :level, :hp_max, :hp_current, :mp_max, :mp_current, :speed, :spell_damage, :attack_damage, :equiped_items

  has_many :items
  has_many :spells

  def get_spell_bonus_type
    case self.object.klass
    when "Warrior"
      0
    when "Wizard"
      self.object.intelligence
    when "Sorcerer"
      self.object.wisdom
    when "Rogue"
      0
    when "Bard"
        self.object.charisma
    when "Paladin"
        self.object.charisma
    else
      0
    end
  end

  def get_attack_bonus_type
    case self.object.klass
    when "Warrior"
        self.object.strength
    when "Wizard"
        0
    when "Sorcerer"
        0
    when "Rogue"
      self.object.dexterity
    when "Bard"
        0
    when "Paladin"
        self.object.strength
    else
      0
    end
  end

  def hp_max
    (self.object.level + self.object.constitution) * 30
  end

  def hp_current
    self.hp_max
  end

  def mp_max
    (self.get_spell_bonus_type + self.object.level) * 100
  end

  def mp_current
    self.mp_max
  end

  def speed
    (self.object.dexterity / 5) + 1
  end

  def spell_damage
    self.get_spell_bonus_type + self.object.level + self.object.get_collective_item_spell_damage
  end

  def attack_damage
    self.get_attack_bonus_type + self.object.level + self.object.get_collective_item_attack_damage
  end
    

  def equiped_items
    self.object.equipment.collect do |e|
      if e.pocket_id != nil
        Pocket.find_by(id: e.pocket_id).item
      end
    end
  end

end
