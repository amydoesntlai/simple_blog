class Article < ActiveRecord::Base

  include TextValidations

  has_many :comments, dependent: :destroy

  attr_accessible :body, :title

  validates :title, :body, :presence => true
  validate :title_long_enough

  def self.sort(params)
    Article.find(:all, :order => self.order_by(params[:order_by]), :limit => params[:max])
  end


  def self.order_by(param)
    case param
    when 'title'     then Article.order('title')
    when 'published' then Article.order('created_at DESC')
    when 'word_count' then Article.order('LENGTH(body)')
    else                  Article.all
    end
  end

  def self.limit(param)
    case param
    when '2'  then Article.all(:limit => 2)
    else               Article.all
    end
  end

  private
  def title_long_enough
    raise('title not long enough!') if self.title.length < 2
  end

end
