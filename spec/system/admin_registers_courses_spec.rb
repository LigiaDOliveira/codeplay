require 'rails_helper'

describe 'Admin registers courses' do
  it 'from index page' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                             bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                                   filename:'ednaldo-pereira.png',
                                   content_type: 'application/png')
    visit root_path
    click_on 'Cursos'

    expect(page).to have_link('Registrar um Curso',
                              href: new_course_path)
  end

  it 'successfully' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                             bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                                   filename:'ednaldo-pereira.png',
                                   content_type: 'application/png')
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    select 'Ednaldo Pereira', from: 'Professor'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: '22/12/2033'
    click_on 'Criar curso'

    expect(current_path).to eq(course_path(Course.last))
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                             bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                                   filename:'ednaldo-pereira.png',
                                   content_type: 'application/png')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', docent: ednaldo)

    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'
    fill_in 'Nome', with: ''
    select 'Ednaldo Pereira', from: 'Professor'
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    fill_in 'Data limite de matrícula', with: ''
    click_on 'Criar curso'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  it 'and code must be unique' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                             bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                                   filename:'ednaldo-pereira.png',
                                   content_type: 'application/png')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', docent: ednaldo)

    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Criar curso'

    expect(page).to have_content('já está em uso')
  end
  
end
