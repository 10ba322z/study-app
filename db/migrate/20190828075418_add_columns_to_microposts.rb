class AddColumnsToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :start_at, :datetime
    add_column :microposts, :end_at, :datetime
  end
end
