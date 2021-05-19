class Docent < ApplicationRecord
  validates :name,:email, presence:{message: 'não pode ficar em branco'}
  validates :email,uniqueness:{message: 'já está em uso'}
  
  has_one_attached :profile_picture

  after_create :attach_default_profile_picture

  def attach_default_profile_picture
    return if profile_picture.attached?
    profile_picture.attach(io: File.open('./spec/files/default.png'),filename: 'default.png')
  end
end
