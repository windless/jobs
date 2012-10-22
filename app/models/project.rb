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

  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :sprints

  validates :name,
    presence: true,
    length: { maximum: 255 }
  validates :description,
    length: { maximum: 255 }

  default_scope order: 'created_at DESC'
  scope :with_creator, joins(:creator)

  def self.search(search, page)
    if search
      with_creator.where("name LIKE ?", "%#{search}%").paginate(page: page, per_page: 10)
    else
      with_creator.paginate(page: page, per_page: 10)
    end
  end

  def current_sprint
    logger.debug "sprints: #{sprints.count}"
    sprints.first
  end
end
