class User < ApplicationRecord
  belongs_to :province, optional: true
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
