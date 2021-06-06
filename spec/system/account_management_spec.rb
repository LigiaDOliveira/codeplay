require 'rails_helper'

describe 'Account management' do
  context 'registration' do
    it 'with email and password' do
      visit root_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'jane@doe.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Criar conta'
  
      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@doe.com.br')
      expect(page).to have_link('Cursos')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Cadastre-se')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      visit root_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      fill_in 'Confirmação de senha', with: ''
      click_on 'Criar conta'

      expect(page).to_not have_text('Login efetuado com sucesso')
      expect(page).to have_content('não pode ficar em branco', count: 2)
      expect(page).to_not have_link('Cursos')
      expect(page).to have_link('Cadastre-se')
      expect(page).to_not have_link('Sair')
    end

    it 'password does not match confirmation' do
      visit root_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'antonia@test.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: ''
      click_on 'Criar conta'

      expect(page).to_not have_text('Login efetuado com sucesso')
      expect(page).to have_content('Confirmação de senha precisa ser igual à senha')
      expect(page).to_not have_link('Cursos')
      expect(page).to have_link('Cadastre-se')
      expect(page).to_not have_link('Sair')
    end

    it 'with email not unique' do
      user = User.create!(email: 'mariana@test.com.br',password: '123456')
      visit root_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'mariana@test.com.br'
      fill_in 'Senha', with: 'outras'
      fill_in 'Confirmação de senha', with: 'outras'
      click_on 'Criar conta'

      expect(page).to_not have_text('Login efetuado com sucesso')
      expect(page).to have_content('já está em uso')
      expect(page).to_not have_link('Cursos')
      expect(page).to have_link('Cadastre-se')
      expect(page).to_not have_link('Sair')
    end
  end

  context 'sign in' do
    it 'with email and password' do
      User.create!(email:'joana@test.com.br',password:'123456')
      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'joana@test.com.br'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('joana@test.com.br')
      expect(page).to have_link('Cursos')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Cadastre-se')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'user does not exist' do
      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'maria@test.com.br'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end
      expect(page).to_not have_text('Login efetuado com sucesso')
      expect(page).to have_text('Email ou senha inválida.')
      expect(page).to_not have_text('pedro@test.com.br')
      expect(page).to_not have_link('Cursos')
      expect(page).to have_link('Cadastre-se')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end

  context 'sign out' do
    it 'successful' do
      user = User.create!(email:'paulo@test.com.br',password:'123456')
      login_as user, scope: :user 
      
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('paulo@test.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Cadastre-se')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end