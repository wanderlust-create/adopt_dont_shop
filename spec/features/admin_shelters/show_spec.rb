require 'rails_helper'
RSpec.describe 'the admin shelters show' do

  before :each do
    @shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Happy Adoptions', city: 'Stone Mtn GA', foster_program: true, rank: 1)
    @shelter_3 = Shelter.create!(name: 'Doggy World', city: 'Baltimore MD', foster_program: true, rank: 3)
    @shelter_4 = Shelter.create!(name: 'Forever Home', city: 'Brooklyn NY', foster_program: false, rank: 5)
    @shelter_5 = Shelter.create!(name: 'Jump World', city: 'Manhattan NY', foster_program: true, rank: 17)

    @scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
    @daisy = Pet.create!(name: 'Daisy', age: 4, breed: 'Poodle', adoptable: true, shelter_id: @shelter_1.id)
    @artimus = Pet.create!(name: 'Artimus', age: 7, breed: 'Mut', adoptable: true, shelter_id: @shelter_2.id)
    @apollo = Pet.create!(name: 'Apollo', age: 2, breed: 'Lab', adoptable: true, shelter_id: @shelter_2.id)
    @scruffy = Pet.create!(name: 'Scruffy', age: 3, breed: 'Hot Dog', adoptable: true, shelter_id: @shelter_3.id)
    @pineapple = Pet.create!(name: 'Pineapple', age: 4, breed: 'Cold Dog', adoptable: true, shelter_id: @shelter_3.id)
    @mango = Pet.create!(name: 'Mango', age: 9, breed: 'Fancy Dog', adoptable: true, shelter_id: @shelter_4.id)
    @onion = Pet.create!(name: 'Onion', age: 1, breed: 'Sad Dog', adoptable: true, shelter_id: @shelter_4.id)
    @peach = Pet.create!(name: 'Peach', age: 12, breed: 'Poodle', adoptable: true, shelter_id: @shelter_4.id)

    @app_1= Application.create!(first_name: 'Lemon', last_name: 'Tiger', street_address: '1225 Alvaro Obgeron Dr.', city: 'Mexico City, GA', post_code: '67518', status: "Pending")
    @app_2= Application.create!(first_name: 'Salty', last_name: 'Hippo', street_address: '367 CBTIS Overton St.', city: 'Colima, DC', post_code: '14628', status: "Pending")
    @app_3= Application.create!(first_name: 'Funky', last_name: 'Platypus', street_address: '15 Overpath Pkwy.', city: 'Shenzhen, OH', post_code: '97627', status: "Pending")
    @app_4= Application.create!(first_name: 'Happy', last_name: 'Potter', street_address: '12 Down Town', city: 'Columbus, NJ', post_code: '89725', status: "In Progress")


    ApplicationPet.create!(pet_id:@scooby.id, application_id: @app_1.id)
    ApplicationPet.create!(pet_id:@daisy.id, application_id: @app_1.id)
    ApplicationPet.create!(pet_id:@artimus.id, application_id: @app_1.id)
    ApplicationPet.create!(pet_id:@apollo.id, application_id: @app_2.id)
    ApplicationPet.create!(pet_id:@pineapple.id, application_id: @app_3.id)
    ApplicationPet.create!(pet_id:@mango.id, application_id: @app_3.id)
    ApplicationPet.create!(pet_id:@onion.id, application_id: @app_3.id)
  end

  it 'the admin application show page has a button to approve an adoption' do

    visit "/admin/applications/#{@app_1.id}"

    expect(page).to have_content(@app_1.first_name)
    expect(page).to have_content(@app_1.last_name)
    expect(page).to have_content(@app_1.street_address)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.post_code)
    expect(page).to have_content(@app_1.status)

    expect(page).not_to have_content(@app_2.first_name)
    expect(page).not_to have_content(@app_3.first_name)

    within("#pet_requested-0") do
      expect(page).to have_content(@scooby.name)
      expect(page).to have_content(@scooby.shelter.name)
      expect(page).to have_button("Approve adoption of #{@scooby.name}")
    end

    within("#pet_requested-1") do
      expect(page).to have_content(@daisy.name)
      expect(page).to have_content(@daisy.shelter.name)
      expect(page).to have_button("Approve adoption of #{@daisy.name}")
    end

    within("#pet_requested-2") do
      expect(page).to have_content(@artimus.name)
      expect(page).to have_content(@artimus.shelter.name)
      expect(page).to have_button("Approve adoption of #{@artimus.name}")
    end

    click_button("Approve adoption of #{@daisy.name}")

    within("#pet_requested-1") do

      expect(page).not_to have_button("Approve adoption of #{@daisy.name}")
    end
  end

  it 'the admin application show page has a button to reject an adoption' do

    visit "/admin/applications/#{@app_3.id}"

    expect(page).to have_content(@app_3.first_name)
    expect(page).to have_content(@app_3.last_name)
    expect(page).to have_content(@app_3.street_address)
    expect(page).to have_content(@app_3.city)
    expect(page).to have_content(@app_3.post_code)
    expect(page).to have_content(@app_3.status)

    expect(page).not_to have_content(@app_1.first_name)
    expect(page).not_to have_content(@app_3.first_name)

    within("#pet_requested-0") do
      expect(page).to have_content(@pineapple.name)
      expect(page).to have_content(@pineapple.shelter.name)
      expect(page).to have_button("Approve adoption of #{@pineapple.name}")
      expect(page).to have_button("Reject adoption of #{@pineapple.name}")
    end

    within("#pet_requested-1") do
      expect(page).to have_content(@mango.name)
      expect(page).to have_content(@mango.shelter.name)
      expect(page).to have_button("Approve adoption of #{@mango.name}")
      expect(page).to have_button("Reject adoption of #{@mango.name}")
    end

    within("#pet_requested-2") do
      expect(page).to have_content(@onion.name)
      expect(page).to have_content(@onion.shelter.name)
      expect(page).to have_button("Approve adoption of #{@onion.name}")
      expect(page).to have_button("Reject adoption of #{@onion.name}")
    end

    click_button("Reject adoption of #{@mango.name}")

    within("#pet_requested-1") do
      expect(page).not_to have_button("Approve adoption of #{@mango.name}")
      expect(page).not_to have_button("Reject adoption of #{@mango.name}")
      expect(page).to have_content("#{@mango.name}'s adoption has been rejected.'")
    end
  end
end
