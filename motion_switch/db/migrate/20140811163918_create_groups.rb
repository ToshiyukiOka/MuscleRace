class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :group_name
      t.integer :point
      t.integer :group_id

      t.timestamps
    end
  end
end
