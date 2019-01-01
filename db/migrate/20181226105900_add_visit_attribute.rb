class AddVisitAttribute < ActiveRecord::Migration[5.2]
  def change
    add_column :grades,:open,:boolean,:default=>false
  end
end
