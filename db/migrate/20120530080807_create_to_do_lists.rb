class CreateToDoLists < ActiveRecord::Migration
  def change
    create_table :to_do_lists do |t|
    	t.references :user
    	t.string "name"
    	t.string "priority"
      t.timestamps
    end
  end
end
