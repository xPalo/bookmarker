class AddAuthorToQuote < ActiveRecord::Migration[7.0]
  def change
    add_column :quotes, :author, :string
  end
end
