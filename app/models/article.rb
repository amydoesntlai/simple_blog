class Article < ActiveRecord::Base

  include TextValidations

  has_many :comments, dependent: :destroy

  attr_accessible :body, :title

  validates :title, :body, :presence => true

end
