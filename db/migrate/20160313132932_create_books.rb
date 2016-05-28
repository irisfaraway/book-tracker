class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :start_date
      t.date :end_date
      t.integer :rating

      t.timestamps null: false
    end
  end
end
