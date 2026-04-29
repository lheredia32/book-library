class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :status, presence: true, inclusion: { in: [ "Want to Read", "Currently Reading", "Completed", "On Hold", "Dropped", "Loaned Out" ] }
  validates :rating, inclusion: { in: 0..5, allow_nil: true }
  has_and_belongs_to_many :tags
end
