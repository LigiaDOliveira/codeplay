require 'rails_helper'

describe 'Admin registers docents' do
  it 'from index page' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Cadastrar um Professor',
                              href: new_docent_path)
  end

  it 'successfully' do
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar um Professor'

    fill_in 'Nome', with: 'Jorge'
    fill_in 'Descrição', with: 'Um professor chamado Jorge'
    fill_in 'Email', with: 'jorge@docent.com'
    attach_file 'Foto de perfil', './spec/files/jorge-dazai.jpg'
    click_on 'Cadastrar Professor'

    expect(current_path).to eq(docent_path(Docent.last))
    expect(page).to have_content('Jorge')
    expect(page).to have_content('jorge@docent.com')
    expect(page).to have_content('Um professor chamado Jorge')
    expect(page).to have_css("img[src*='jorge-dazai.jpg']")
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                   filename:'ednaldo-pereira.png', content_type: 'application/png')

    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar um Professor'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Email', with: ''
    attach_file 'Foto de perfil', './spec/files/jorge-dazai.jpg'
    
    click_on 'Cadastrar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and code must be unique' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                   filename:'ednaldo-pereira.png', content_type: 'application/png')

    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar um Professor'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Email', with: 'ednaldo@pereira.com'
    click_on 'Cadastrar Professor'

    expect(page).to have_content('já está em uso')
  end
  
end
