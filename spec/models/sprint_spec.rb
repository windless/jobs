# == Schema Information
#
# Table name: sprints
#
#  id         :integer          not null, primary key
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Sprint do
  let(:project) { FactoryGirl.create :project }
  before { @sprint = project.sprints.create() }

  subject { @sprint }

  it { should respond_to(:project_id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
end

