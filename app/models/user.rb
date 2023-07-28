# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  city            :string
#  aqi_threshold   :integer
#
class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates_uniqueness_of :email

  validates :aqi_threshold, numericality: { greater_than_or_equal_to: 0 }
  validates :city, format: { with: /\A.+\z/, message: "City must be a string" }
end
