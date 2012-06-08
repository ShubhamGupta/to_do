class DropDefaultOnSubjectAndContent < ActiveRecord::Migration
  def up
		change_table :to_do_items do |t|
		  t.change :subject, :string
		  t.change :content, :string
		end
  end

  def down
  change_table :to_do_items do |t|
	  t.change :subject, :string, :default => ''
	  t.change :content, :string, :default => ''
	  end
  end
end
