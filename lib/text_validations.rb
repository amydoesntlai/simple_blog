module TextValidations

  def self.included(base)
    base.validates :body, :format => { :without => /kitten/, :message => "kittens are here!" }
  end

end
