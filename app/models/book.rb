class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :status, presence: true, inclusion: { in: ["Want to Read", "Currently Reading", "Completed", "On Hold", "Dropped", "Loaned Out"] }
end
