class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :subject
      t.text :body
      t.boolean :done

      t.timestamps null: false
    end
  end
end
