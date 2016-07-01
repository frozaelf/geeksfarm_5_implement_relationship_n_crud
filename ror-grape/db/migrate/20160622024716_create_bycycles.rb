class CreateBycycles < ActiveRecord::Migration
  def change
    create_table :bycycles do |t|
      t.string :name
      t.string :series

      t.timestamps
    end
  end
end
