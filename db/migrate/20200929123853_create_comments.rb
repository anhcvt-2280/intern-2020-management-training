class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :parent_id
      t.references :commentable, polymorphic: true
      t.timestamps
    end

    add_index :comments, :user_id
  end
end
