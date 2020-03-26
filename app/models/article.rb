class Article < ApplicationRecord
  paginates_per 10

  enum status: %i[draft published archived]

  belongs_to :user
  has_rich_text :text
  has_one :action_text_rich_text,
    class_name: 'ActionText::RichText',
    as: :record

  validates :title, presence: true, length: { maximum: 100 }
  validates :text, presence: true

  acts_as_taggable_on :categories

  ransack_alias :user, :user_email
end
