class Article < ActiveRecord::Base

  include TextValidations

  has_many :comments, dependent: :destroy

  attr_accessible :body, :title

  validates :title, :body, :presence => true
  validate :title_long_enough

  private
  def title_long_enough
    raise('title not long enough!') if self.title.length < 2
  end

end
