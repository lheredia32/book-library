class AddStatusToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :status, :string, default: "Want to Read", null: false

    # Add index for faster filtering
    add_index :books, :status
  end
end
