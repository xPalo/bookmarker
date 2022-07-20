class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :title_sk
      t.string :isbn

      t.timestamps
    end
  end
end
