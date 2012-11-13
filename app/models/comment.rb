class Comment < ActiveRecord::Base

  include TextValidations

  belongs_to :article

  attr_accessible :body

  validates :body, :length => { :maximum => 250 }
  validates :article, :presence => true
  validates_associated :article

end
