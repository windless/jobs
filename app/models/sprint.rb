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
  has_many :works

  default_scope :order => "created_at DESC"
  scope :recent, limit(5)

  before_save :create_name

  def prepare_name
    name.nil? ? "sprint #{project.sprints.count + 1}" : name
  end

  def uncheck_works
    works.uncheck
  end

  def checked_out_works
    works.started
  end

  def review_works
    works.review
  end

  def complete_works
    works.complete
  end

  private 

  def create_name
    self.name = "sprint #{project.sprints.count + 1}" if name.nil?
  end
end
