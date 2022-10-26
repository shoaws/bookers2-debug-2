class Tag < ApplicationRecord
  has_many :booktags,dependent: :destroy, foreign_key: 'tag_id'
  has_many :books,through: :booktags
end
