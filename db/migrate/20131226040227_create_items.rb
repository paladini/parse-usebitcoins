class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :type
      t.string :category

      t.timestamps
    end
  end
end
