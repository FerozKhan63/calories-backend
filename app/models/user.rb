class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :meals

  validates :calorie_limit, presence: true, numericality: true, on: :update
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def calorie_limit_exceeds
    calorie_intake_today = meals.where('? BETWEEN start_date AND end_date', Date.today).sum(:calorie_intake)

    (calorie_intake_today > calorie_limit)
  end
end
