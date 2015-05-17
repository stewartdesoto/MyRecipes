class Chef < ActiveRecord::Base
  before_save{self.email = email.downcase}
  validates :name, presence: true, length: {minimum: 3, maximum: 40}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: {case_sensitive: false},
                    format: {with: VALID_EMAIL_REGEX}
end