class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :score
      t.string :body
      t.timestamp :reviewed_at

      t.timestamps
    end
  end
end
