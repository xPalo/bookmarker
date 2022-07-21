class AddTranslationToQuotes < ActiveRecord::Migration[7.0]
  def change
    rename_column :quotes, :content, :content_en
    add_column :quotes, :content_sk, :string
  end
end
