class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :start_time
      t.string :end_time
      t.integer :item_id
      t.string :description

      t.timestamps
    end
  end
end
