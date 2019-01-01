class CreateSemesters < ActiveRecord::Migration[5.2]
  def change
    create_table :semesters do |t|
      t.string :info ,null:false
      t.timestamps null: false
    end
  end
end
