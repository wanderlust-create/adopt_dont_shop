class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.pending_applications
    find_by_sql("SELECT DISTINCT  shelters.* FROM shelters INNER JOIN pets ON pets.shelter_id = shelters.id INNER JOIN application_pets ON application_pets.pet_id = pets.id INNER JOIN applications ON applications.id = application_pets.application_id WHERE applications.status ='Pending'")
  end

  def self.order_reverse_alphaetical
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC;")
  end


  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end
