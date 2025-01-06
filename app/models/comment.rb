class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true

  validates :content, presence: true
  validates :anonymous_name, presence: true, if: :anonymous_comment?

  def anonymous_comment?
    user.nil? && anonymous_name.blank? == false
  end
end
