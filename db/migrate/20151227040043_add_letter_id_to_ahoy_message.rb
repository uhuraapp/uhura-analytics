class AddLetterIdToAhoyMessage < ActiveRecord::Migration
  def change
    add_column :ahoy_messages, :letter_id, :integer
  end
end
