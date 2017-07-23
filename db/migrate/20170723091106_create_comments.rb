class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :title
      t.string :content
      t.references :movie, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
