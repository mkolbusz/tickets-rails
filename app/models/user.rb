class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :date_of_birth, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  validate :check_date_of_birth

  has_many :events
  has_many :tickets

  def add_money 
    self.money = self.money + self.money_was
  end

  def is_adult
    Date.today.year - self.date_of_birth.year >= 18
  end

  def check_date_of_birth
    if self.date_of_birth.try(:to_date)
      if Date.today.year - self.date_of_birth.to_date.year > 100
        errors.add('Date of birth', 'has bad value')
      end
    end
  end
end
