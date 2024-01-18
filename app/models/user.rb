class User < ApplicationRecord

  validates :uuid, presence: true, uniqueness: true

  def full_name
     "#{name['title']} #{name['first']} #{name['last']}"
  end
end
