class Restaurant < ActiveRecord::Base
  belongs_to :user

  has_many :reviews,
    -> {extending WithUserAssociationExtension},
    dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true


  def build_review(attributes = {}, user)
    attributes[:user] ||= user
    reviews.build(attributes)
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating).to_i
  end

end
