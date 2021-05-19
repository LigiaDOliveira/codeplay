require 'rails_helper'

describe 'Admin deletes docent' do
  it 'successfully' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                   bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg')

    visit docent_path(jorge)
    expect { click_on 'Descadastrar' }.to change { Docent.count }.by(-1)

    expect(page).to have_text('Professor descadastrado com sucesso')
    expect(current_path).to eq(docents_path)

  end
end