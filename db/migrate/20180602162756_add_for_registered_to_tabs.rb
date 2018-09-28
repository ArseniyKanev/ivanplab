class AddForRegisteredToTabs < ActiveRecord::Migration[5.0]
  def change
    add_column :tabs, :for_registered, :boolean, default: false
  end
end
