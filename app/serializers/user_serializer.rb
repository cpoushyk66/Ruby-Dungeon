class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :admin, :image, :dark_mode

end
