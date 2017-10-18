class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.text :image_data
      t.string :user_name
      t.text :bio
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
