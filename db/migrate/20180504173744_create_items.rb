class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :brand_id
      t.integer :category_id
    end
  end
end
