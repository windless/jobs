class Work < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :sprint
  belongs_to :checker, class_name: "User", foreign_key: :checker_id

  scope :uncheck, where(state: :uncheck)
  scope :started, where(state: :started)
  scope :review, where(state: :review)
  scope :complete, where(state: :complete)

  def check_out_by!(user)
    self.checker = user
    self.state = :started
    save!
  end

  def finish!
    self.state = :review
    save!
  end

  def review!
    self.state = :complete
    save!
  end
end
