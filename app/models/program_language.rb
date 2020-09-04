class ProgramLanguage < ApplicationRecord
  has_many :users, dependent: :nullify
end
