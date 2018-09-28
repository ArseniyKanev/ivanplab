class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.string :title_en
      t.string :title_ru
      t.text :text_en
      t.text :text_ru

      t.timestamps null: false
    end
  end
end
