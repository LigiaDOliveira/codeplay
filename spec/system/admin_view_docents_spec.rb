require 'rails_helper'

describe 'Admin view docents' do
  it 'successfully' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                   bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg')
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                   filename:'ednaldo-pereira.png', content_type: 'application/png')
    # byebug
    visit root_path
    # byebug
    click_on 'Professores'
    expect(page).to have_content('Jorge')
    expect(page).to have_content('jorge@docent.com')
    expect(page).to have_content('Um professor chamado Jorge')
    expect(page).to have_css("img[src*='jorge-dazai.jpg']")
    expect(page).to have_content('Ednaldo Pereira')
    expect(page).to have_content('ednaldo@pereira.com')
    expect(page).to have_content('Um professor chamado Ednaldo Pereira')
    expect(page).to have_css("img[src*='ednaldo-pereira.png']")
  end

  it 'and view details' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                   bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg')
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                   filename:'ednaldo-pereira.png', content_type: 'application/png')
    
    visit root_path
    click_on 'Professores'
    click_on 'Jorge'

    expect(page).to have_content('Jorge')
    expect(page).to have_content('jorge@docent.com')
    expect(page).to have_content('Um professor chamado Jorge')
    expect(page).to have_css("img[src*='jorge-dazai.jpg']")
  end

  it 'and no docent is added' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content ('Nenhum professor cadastrado')
  end

  it 'and return to home page' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                   filename:'ednaldo-pereira.png', content_type: 'application/png')
    
    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    ednaldo = Docent.create!(name: 'Ednaldo Pereira', email: 'ednaldo@pereira.com', 
                   bio: 'Um professor chamado Ednaldo Pereira')
    ednaldo.profile_picture.attach(io: File.open('./spec/files/ednaldo-pereira.png'),
                   filename:'ednaldo-pereira.png', content_type: 'application/png')

    visit root_path
    click_on 'Professores'
    click_on 'Ednaldo Pereira'
    click_on 'Voltar'

    expect(current_path).to eq docents_path
  end

  it 'and attach default profile picture if none specified' do
    professor = Docent.create!(name: 'Professor Default', email: 'default@docent.com', 
                               bio: 'Um professor chamado Professor Default')
    visit root_path
    click_on 'Professores'
    click_on 'Professor Default'

    expect(page).to have_css("img[src*='default.png']")
  end

end