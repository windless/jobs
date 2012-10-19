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
  attr_accessible :name
  belongs_to :project

end
