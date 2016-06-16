class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :image
      t.boolean :published

      t.timestamps
    end
  end
end
