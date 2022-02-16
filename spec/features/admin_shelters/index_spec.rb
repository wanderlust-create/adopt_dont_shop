require 'rails_helper'
RSpec.describe 'the admin shelters index' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Happy Adoptions', city: 'Stone Mtn GA', foster_program: true, rank: 1)
    @shelter_3 = Shelter.create!(name: 'Doggy World', city: 'Baltimore MD', foster_program: true, rank: 3)
    @shelter_4 = Shelter.create!(name: 'Forever Home', city: 'Brooklyn NY', foster_program: false, rank: 5)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  it 'Admin/Shelters#index lists the shelters in reverse alphabetical order by name' do
    visit '/admin/shelters'

    within("#shelter-0") do
      expect(page).to have_content(@shelter_1.name)
    end

    within("#shelter-1") do
      expect(page).to have_content(@shelter_2.name)
    end

    within("#shelter-2") do
      expect(page).to have_content(@shelter_4.name)
    end

    within("#shelter-3") do
      expect(page).to have_content(@shelter_3.name)
    end

  end

  it 'Admin/Shelters#index lists has a section that lists every shelter that has pending applications' do

    @app_1= Application.create(first_name: 'Lemon', last_name: 'Tiger', street_address: '1225 Alvaro Obgeron Dr.', city: 'Mexico City, GA', post_code: '67518', status: "In Progress")
    @app_2= Application.create(first_name: 'Salty', last_name: 'Hippo', street_address: '367 CBTIS Overton St.', city: 'Colima, DC', post_code: '14628', status: "Pending")
    @app_3= Application.create(first_name: 'Funky', last_name: 'Platypus', street_address: '15 Overpath Pkwy.', city: 'Shenzhen, OH', post_code: '97627', status: "In Progress")
    @app_4= Application.create(first_name: 'Happy', last_name: 'Potter', street_address: '12 Down Town', city: 'Columbus, NJ', post_code: '89725', status: "Pending")

    ApplicationPet.create!(pet_id:@pet_1.id, application_id: @app_2.id)
    ApplicationPet.create!(pet_id:@pet_2.id, application_id: @app_2.id)
    ApplicationPet.create!(pet_id:@pet_3.id, application_id: @app_4.id)

    visit '/admin/shelters'

    within("#shelter_apps-0") do
      expect(page).to have_content(@shelter_1.name)
    end

    within("#shelter_apps-1") do
      expect(page).to have_content(@shelter_3.name)
    end

  end
end
