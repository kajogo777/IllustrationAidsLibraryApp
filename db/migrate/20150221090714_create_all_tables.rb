class CreateAllTables < ActiveRecord::Migration
  def change

create_table :categories do |t|

      t.string :name
      t.text :description

      t.timestamps null: false
end

create_table :check_ins do |t|

      t.integer :item_id , null: false
      t.integer :person_id , null: false
      t.boolean :on_deadline , default: true

      t.timestamps null: false
end
add_index :check_ins,[ :item_id, :person_id], unique: false
    
create_table :check_outs do |t|

      t.datetime :check_out_date
      t.datetime :deadline_date
      t.boolean :released, default: false
      t.integer :item_id, null: false
      t.integer :person_id, null: false

      t.timestamps null: false
end
add_index :check_outs,[ :item_id, :person_id], unique: true

create_table :items do |t|

      t.string :name
      t.text :description
      t.float :cost
      t.string :condition
      t.integer :category_id
      t.integer :sub_category_id
      t.integer :location_id
      t.string :photo

      t.timestamps null: false
end
add_index :items , [ :category_id, :sub_category_id], unique: false
    
create_table :items_tags, id: false do |t|

    	t.integer :item_id, null: false
    	t.integer :tag_id, null: false

end
add_index :items_tags , [ :item_id, :tag_id] , unique: true

create_table :locations do |t|

      t.string :loc1
      t.string :loc2
      t.string :loc3
      t.text :description

      t.timestamps null: false
end

create_table :people do |t|

      t.string :nationalid, unique: true, null: false
      t.date :birth_date
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :addressA
      t.string :addressB
      t.string :addressC
      t.string :addressD
      t.string :phone_number
      t.string :mobile_number1
      t.string :mobile_number2
      t.integer :role_id
      

      t.timestamps null: false
end
add_index :people,[ :nationalid ], unique: true

create_table :people_services, id: false do |t|

  		t.integer :person_id, null: false
  		t.integer :service_id, null: false
  		
end
add_index :people_services,[ :person_id, :service_id], unique: true

create_table :roles do |t|

      t.string :name, unique: true, null: false
      t.text :description

      t.timestamps null: false
end
add_index :roles , [:name], unique: true

create_table :services do |t|

      t.string :name, null: false
      t.string :sub_name

      t.timestamps null: false
end

create_table :sub_categories do |t|

      t.string :name
      t.text :description
      t.integer :category_id, null: false

      t.timestamps null: false
end

create_table :tags do |t|

      t.string :name, unique: true, null: false

      t.timestamps null: false
end
add_index :tags , [:name] ,unique: true

  end
end
