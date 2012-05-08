class Question < ActiveRecord::Base
  validates_presence_of :title
  has_many :options
end
