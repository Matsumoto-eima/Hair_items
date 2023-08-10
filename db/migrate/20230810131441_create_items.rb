class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: true
      t.text :description, null: false
      t.timestamps
    end
  end
end
