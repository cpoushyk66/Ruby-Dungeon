class User < ApplicationRecord
    validates :username, uniqueness: true

    has_many :characters, dependent: :destroy

    def self.give_admin_access(admin, user)
        if (admin.admin)
            user.update(admin: true)
            true
        else
            false
        end
    end
end
