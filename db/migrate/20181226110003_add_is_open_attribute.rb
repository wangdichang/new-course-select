class AddIsOpenAttribute < ActiveRecord::Migration[5.2]
  def change
     add_column :semesters,:is_open,:boolean,:default=>false
  end
end
