# == Schema Information
#
# Table name: sprints
#
#  id         :integer          not null, primary key
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sprint < ActiveRecord::Base
  attr_accessible :description
  belongs_to :project

  before_save :create_name

  default_scope :order => "created_at DESC"
  scope :recent, limit(5)

  private

  def create_name
    self.name = "sprint #{project.sprints.count + 1}"
  end
end
