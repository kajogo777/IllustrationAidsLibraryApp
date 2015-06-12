class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :person_id , null: false
      t.integer :item_id
      t.text :description

      t.timestamps null: false
    end
  end
end
