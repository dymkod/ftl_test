class Url < ApplicationRecord
  CODE_LENGHT = 8

  validates_presence_of :url, :code
end