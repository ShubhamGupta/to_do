class DropDefaultOnSubjectAndContent < ActiveRecord::Migration
  def up
	  change_column_default(:to_do_items, :subject, nil)
	  change_column_default(:to_do_items, :content, nil)
  end

  def down
	  change_column_default(:to_do_items, :subject, "")
	  change_column_default(:to_do_items, :content, "")
  end
end
