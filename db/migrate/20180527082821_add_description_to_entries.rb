class AddDescriptionToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :description, :text
  end
end
