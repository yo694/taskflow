class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name,null: false
      t.text :description
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.integer :tasks_count,default: 0, null: false

      t.timestamps
    end
  end
end
