class ProjectMember < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :role, presence: true

end
