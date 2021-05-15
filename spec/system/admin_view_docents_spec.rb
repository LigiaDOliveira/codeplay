require 'rails_helper'

describe 'Admin view docents' do
  it 'successfully' do
    Docent.create!(name: 'Jorge', email: 'jorge@docent.com', 
                   bio: 'Um professor chamado Jorge',
                   profile_picture: attach_file('pfp1','./spec/files/jorge-dazai.jpg'))
    Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira',
                   profile_picture: attach_file('pfp2','./spec/files/ednaldo-pereira.png'))
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Jorge')
    expect(page).to have_content('jorge@docent.com')
    expect(page).to have_content('Um professor chamado Jorge')
    expect(page.find('#pfp')['src']).to have_content('jorge-dazai.jpg')
    expect(page).to have_content('Ednaldo Pereira')
    expect(page).to have_content('ednaldo@pereira.com')
    expect(page).to have_content('Um professor chamado Ednaldo Pereira')
    expect(page.find('#pfp')['src']).to have_content('ednaldo-pereira.png')
  end

  it 'and view details' do
    Docent.create!(name: 'Jorge', email: 'jorge@docent.com', 
                   bio: 'Um professor chamado Jorge',
                   profile_picture: attach_file('pfp1','./spec/files/jorge-dazai.jpg'))
    Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira',
                   profile_picture: attach_file('pfp2','./spec/files/ednaldo-pereira.png'))
    
    visit root_path
    click_on 'Professores'
    click_on 'Jorge'

    expect(page).to have_content('Jorge')
    expect(page).to have_content('jorge@docent.com')
    expect(page).to have_content('Um professor chamado Jorge')
    expect(page.find('#pfp')['src']).to have_content('jorge-dazai.jpg')
  end

  it 'and no docent is added' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content ('Nenhum professor cadastrado')
  end

  it 'and return to home page' do
    Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira',
                   profile_picture: attach_file('pfp2','./spec/files/ednaldo-pereira.png'))
    
    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira',
                   profile_picture: attach_file('pfp2','./spec/files/ednaldo-pereira.png'))

    visit root_path
    click_on 'Professores'
    click_on 'Jorge'
    click_on 'Voltar'

    expect(current_path).to eq docents_path
  end

end