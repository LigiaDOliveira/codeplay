require 'rails_helper'

describe 'Admin updates docent' do
  it 'successfully' do
    ednaldo = Docent.create!(name: 'EdnaldoPereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                   filename:'ednaldo-pereira.png', content_type: 'application/png')

    visit root_path
    click_on 'Professores'
    click_on 'EdnaldoPereira'
    click_on 'Editar'

    fill_in 'Nome', with: 'Ednaldo Pereira'
    fill_in 'Descrição', with: 'Um professor chamado Ednaldo Pereira'
    fill_in 'Email', with: 'ednaldo@pereira.com'
    attach_file 'Foto de perfil', './spec/files/ednaldo-pereira.png'

    click_on 'Atualizar Professor'

    expect(page).to have_content('Ednaldo Pereira')
    expect(page).to have_content('ednaldo@pereira.com')
    expect(page).to have_content('Um professor chamado Ednaldo Pereira')
    expect(page).to have_css("img[src*='ednaldo-pereira.png']")
  end

  scenario 'and attributes cannot be blank' do
    ednaldo = Docent.create!(name: 'EdnaldoPereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                   filename:'ednaldo-pereira.png', content_type: 'application/png')

    visit root_path
    click_on 'Professores'
    click_on 'EdnaldoPereira'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Email', with: ''
    attach_file 'Foto de perfil', './spec/files/jorge-dazai.jpg'
    click_on 'Atualizar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    ednaldo = Docent.create!(name: 'EdnaldoPereira', email: 'ednaldo@pereira.com', 
                             bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                                   filename:'ednaldo-pereira.png', content_type: 'application/png')
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg')

    visit root_path
    click_on 'Professores'
    click_on 'EdnaldoPereira'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Email', with: 'jorge@docent.com'
    click_on 'Atualizar Professor'

    expect(page).to have_content('já está em uso')
  end
end
