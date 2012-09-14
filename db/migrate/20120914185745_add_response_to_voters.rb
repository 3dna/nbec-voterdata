class AddResponseToVoters < ActiveRecord::Migration

  def up
    add_column :voters, :response, :text
  end

  def down
    remove_column :voters, :response
  end

end
