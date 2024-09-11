class Evaluation < ApplicationRecord
    belongs_to :project
    belongs_to :evaluator, class_name: 'User'
end
