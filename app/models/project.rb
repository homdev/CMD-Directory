class Project < ApplicationRecord
    belongs_to :user
    has_many :evaluations

    belongs_to :project_leader, class_name: 'User', foreign_key: 'project_leader_id', optional: true
    has_many :project_members, dependent: :destroy
    has_many :members, through: :project_members, source: :user  
    
    has_many :users, through: :project_members
    has_many :milestones
    has_many :tasks
    has_many :risks, dependent: :destroy

    accepts_nested_attributes_for :risks, allow_destroy: true

    validates :name, :start_date, :end_date, :funding_needed, presence: true
end
