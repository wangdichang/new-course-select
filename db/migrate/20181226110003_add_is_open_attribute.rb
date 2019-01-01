class AddIsOpenAttribute < ActiveRecord::Migration[5.0]
  def change
     add_column :semesters,:is_open,:boolean,:default=>false
  end
end
