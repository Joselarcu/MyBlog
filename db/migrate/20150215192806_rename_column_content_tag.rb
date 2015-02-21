class RenameColumnContentTag < ActiveRecord::Migration
  def change
  	rename_column :tags, :content, :tag_content
  end
end
