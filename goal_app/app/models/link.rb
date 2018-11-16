# == Schema Information
#
# Table name: links
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Link < ApplicationRecord
  validates :title, :url, presence: true
  
  belongs_to :user,
    class_name: :User,
    foreign_key: :user_id

  has_many :comments,
    class_name: :Comment,
    foreign_key: :link_id
  
end
