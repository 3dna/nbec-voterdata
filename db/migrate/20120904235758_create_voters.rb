class CreateVoters < ActiveRecord::Migration
  def change
    create_table :voters do |t|
      t.string :first_name
      t.string :last_name
      t.integer :voter_id
      t.string :email

      t.timestamps
    end
  end
end
