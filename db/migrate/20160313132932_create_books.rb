class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :start
      t.date :end
      t.integer :rating

      t.timestamps null: false
    end
  end
end
