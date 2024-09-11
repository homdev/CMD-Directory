class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, admin: 1, moderator: 2, member: 3 }

  has_one_attached :profile_image
  has_one_attached :banner_image
  validates :role, presence: true
  has_many :projects, dependent: :destroy

  has_many :project_members
  has_many :member_projects, through: :project_members, source: :project

 # Validation des champs requis
 validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
 validates :password, presence: true, if: :password_required?

 # Méthode pour déterminer si un mot de passe est requis
 def password_required?
   new_record? || password.present?
 end

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'email', 'name', 'surname', 'username', 'created_at', 'updated_at', 'role', 'address', 'city', 'country', 'profession', 'phone_number']
  end

  def self.ransackable_associations(auth_object = nil)
    %w[profile_image]
  end
end
