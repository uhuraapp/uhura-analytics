class AddUniqueSendToLetter < ActiveRecord::Migration
  def change
    add_column :letters, :unique_send, :boolean
  end
end
