class DropDefaultOnSubjectAndContent < ActiveRecord::Migration
  def up
		change_table :to_do_itemsc do |t|
		  t.remove :subject, :content
		  t.string :subject
		  t.string :content
		end
  end

  def down
  end
end
