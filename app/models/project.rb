# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Project < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :user
  has_many :sprints

  validates :name,
    presence: true,
    length: { maximum: 255 }
  validates :description,
    length: { maximum: 255 }

  default_scope order: 'created_at DESC'

  def creator
    user
  end

  def self.search(search, page)
    if search
      where("name LIKE ?", "%#{search}%").paginate(page: page, per_page: 10)
    else
      paginate(page: page, per_page: 10)
    end
  end

  def current_sprint
    sprints.first
  end
end
