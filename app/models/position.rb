class Position < ApplicationRecord
  has_many :users, dependent: :nullify
end
