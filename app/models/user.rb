class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def gravatar_url
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}"
  end

  # Thought: in production, posts and threads could use some kind of lookup hash
  # so we're not throwing around DB ID's
  #
  # this would be like an after_save hook
  #
  # Usage: Xyz.find_by(safe_hash: params['safe_hash'])
  #
  # def rehash
  #   # md5 is probably fine here, better hash is better
  #
  #   new_hash = Digest::MD5("#{id} #{created_at} #{email}")
  #   or_why_not_do_this_after_create_only = Digest::MD5("#{id} #{created_at} #{Math::random}")
  #   update_columns(safe_hash: new_hash)
  # end
end
