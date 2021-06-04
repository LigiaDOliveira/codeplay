require 'rails_helper'

describe 'Visitor creates account' do
  it 'with email and password' do
    visit root_path
    click_on 'Cadastre-se'
    fill_in 'Email', with: 'jane@doe.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de Senha', with: '123456'
    click_on 'Criar conta'

    expect(page).to have_text('Login efetuado com sucesso')
    expect(page).to have_text('jane@doe.com.br')
    expect(page).to have_link('Cursos')
    expect(current_path).to eq(root_path)
    expect(page).to_not have_link('Cadastre-se')
    expect(page).to have_link('Sair')
  end
end