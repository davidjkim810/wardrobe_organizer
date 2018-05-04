class CreateWardrobes < ActiveRecord::Migration[5.2]
  def change
    create_table :wardrobes do |t|
      t.string :name
      t.string :season
      t.integer :user_id
    end
  end
end
