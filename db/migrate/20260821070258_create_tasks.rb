class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.references :assignee, null: false, foreign_key: {to_table: :users}
      t.string :title,null: false
      t.integer :status,null: false,default: 0
      t.date :due_on
      t.datetime :completed_at

      t.timestamps
    end
  end
end
