class Department < ApplicationRecord
  has_many :users, dependent: :nullify
end
