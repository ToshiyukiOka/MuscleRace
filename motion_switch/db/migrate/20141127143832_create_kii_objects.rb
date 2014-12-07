class CreateKiiObjects < ActiveRecord::Migration
  def change
    create_table :kii_objects do |t|
      t.string :user_name
      t.integer :counts

      t.timestamps
    end
  end
end
