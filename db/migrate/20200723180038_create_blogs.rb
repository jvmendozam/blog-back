class CreateBlogs < ActiveRecord::Migration[6.0]
  def up
    create_table :blogs do |t|
      t.string :title
      t.string :resume
      t.string :body
      t.string :picture
      t.references :user
      t.timestamps
    end
  end

  def down 
    drop_table :blogs
  end
end
