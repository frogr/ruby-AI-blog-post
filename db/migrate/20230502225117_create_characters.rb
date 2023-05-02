class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :trait_1
      t.string :trait_2
      t.string :backstory

      t.timestamps
    end
  end
end
