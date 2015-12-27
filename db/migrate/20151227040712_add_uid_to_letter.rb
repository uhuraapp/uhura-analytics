class AddUidToLetter < ActiveRecord::Migration
  def change
    add_column :letters, :uid, :string
  end
end
