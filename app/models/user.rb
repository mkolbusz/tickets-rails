class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :tickets

  def add_money 
    self.money = self.money + self.money_was
  end

  def is_adult
    Date.today.year - self.date_of_birth.year >= 18
  end
end
