class AddItemImgToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :image, :string, null: false, default: "../../assets/images/question.png"
  end
end
