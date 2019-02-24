class AddHashValueToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :hash_value, :string
  end
end
