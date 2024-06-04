class CreateDownloadActions < ActiveRecord::Migration[7.0]
  def change
    create_table :download_actions do |t|
      t.references :user, foreign_key: true
      t.string :filename

      t.timestamps
    end
  end
end
