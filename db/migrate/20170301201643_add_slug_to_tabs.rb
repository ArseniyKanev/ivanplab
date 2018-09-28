class AddSlugToTabs < ActiveRecord::Migration[5.0]
  def change
    add_column :tabs, :slug, :string
    add_index :tabs, :slug, unique: true
  end
end
