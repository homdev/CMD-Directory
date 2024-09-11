class Task < ApplicationRecord
  belongs_to :project

  belongs_to :project
  belongs_to :assigned_to, class_name: 'User', optional: true

  validates :title, :status, presence: true
end
