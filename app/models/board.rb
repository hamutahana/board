class Board < ApplicationRecord
	has_many :comments

	validates :author_name, presence: true, length: { maximum: 10 }
	validates :title, presence: true, length: { maximum: 100 }
	validates :body, presence: true, length: { maximum: 1000 }
end
