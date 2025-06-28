class User < ApplicationRecord
  
  has_one_attached :profile_image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_one_attached :image  
  has_many :books, dependent: :destroy  

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height])
    else
      ActionController::Base.helpers.asset_path('default-image.jpg')
    end
  end
  def display_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height])
    else
      ActionController::Base.helpers.asset_path('default-image.jpg')
    end
  end
end
