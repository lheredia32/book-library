class AddRatingAndReviewToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :rating, :integer
    add_column :books, :review, :text
  end
end
