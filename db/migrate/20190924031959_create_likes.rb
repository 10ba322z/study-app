class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps

      t.index :user_id
      t.index :micropost_id
      t.index [:user_id, :micropost_id], unique: true
    end
  end
end
