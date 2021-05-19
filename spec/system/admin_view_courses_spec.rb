require 'rails_helper'

describe 'Admin view courses' do
  it 'successfully' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg') 
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: jorge)
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033', instructor: jorge)

    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
  end

  it 'and view details' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg') 
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: jorge)
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033', instructor: jorge)

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('Jorge')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
  end

  it 'and no course is available' do
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Nenhum curso disponível')
  end

  it 'and return to home page' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg') 
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: jorge)

    visit root_path
    click_on 'Cursos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg') 
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: jorge)

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq courses_path
  end
end
