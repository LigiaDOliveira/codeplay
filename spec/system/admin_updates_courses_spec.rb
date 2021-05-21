require 'rails_helper'

describe 'admin updates courses' do
  it 'successfully' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                             bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                                   filename:'ednaldo-pereira.png',
                                   content_type: 'application/png')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', docent: ednaldo)
    visit course_path(course)
    click_on 'Editar'
    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de RoR'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: Date.current.strftime('%d/%m/%Y')
    click_on 'Salvar'

    expect(page).to have_text('Ruby on Rails')
    expect(page).to have_text('Um curso de RoR')
    expect(page).to have_text('RUBYONRAILS')
    expect(page).to have_text('30')
    expect(page).to have_text(Date.current.strftime('%d/%m/%Y'))

  end
end