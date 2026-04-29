class AddDefaultLoanedToBooks < ActiveRecord::Migration[8.0]
  def change
    change_column_default :books, :loaned, from: nil, to: false
  end
end
