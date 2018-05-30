class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :entry, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:user_id, :entry_id], unique: true
  end
end
