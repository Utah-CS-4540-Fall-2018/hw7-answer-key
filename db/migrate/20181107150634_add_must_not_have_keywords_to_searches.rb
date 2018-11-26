class AddMustNotHaveKeywordsToSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :keyword_must_have, :string
    add_column :searches, :keyword_must_not_have, :string
  end
end
