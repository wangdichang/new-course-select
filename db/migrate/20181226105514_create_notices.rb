class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.string :title
      t.text :text
      t.string :department
      t.timestamps null: false
    end
  end
end
