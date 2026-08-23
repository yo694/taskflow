class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.text :body,null: false

      t.timestamps
    end
add_index :comments, [:commentable_type, :commentable_id], unique: true
  end
end
