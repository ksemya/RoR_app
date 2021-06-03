class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :file
      t.float :ave_value
      t.integer :theme_id

      t.timestamps
    end
  end
end
