class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :language_code
      t.string :content
      t.string :url
      t.timestamp :published_at

      t.timestamps
    end
  end
end
