class Post < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Post', foreign_key: 'parent_id', optional: true
  has_many :responses, class_name: 'Post', foreign_key: 'parent_id'

  def archive!
    update(archived_at: Time.current)
  end
end
