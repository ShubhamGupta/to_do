class CreateToDoItems < ActiveRecord::Migration
  def change
    create_table :to_do_items do |t|
    	t.string :subject, :default => ""
    	t.text :content, :default => ""
    	t.string :priority
    	t.date :remind_on
    	t.time :remind_at
    	t.references :to_do_list
			t.timestamps
    end
  end
end
