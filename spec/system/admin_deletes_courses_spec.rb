require 'rails_helper'

describe 'Admin deletes courses' do
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
    expect { click_on 'Apagar' }.to change { Course.count }.by(-1)

    expect(page).to have_text('Curso apagado com sucesso')
    expect(current_path).to eq(courses_path)
  end
end