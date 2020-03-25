class Article < ApplicationRecord
  default_scope { where(status: :published) }

  enum status: %i[draft published archived]

  belongs_to :user
  has_rich_text :text

  validates :title, presence: true, length: { maximum: 100 }

  acts_as_taggable_on :categories
end
