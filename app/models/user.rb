class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable,:lockable,:timeoutable,
  # :omniauthable,:validatable

  devise :database_authenticatable, :rememberable, :trackable, :registerable, :recoverable

	belongs_to :person, dependent: :destroy
end
