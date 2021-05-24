require 'rails_helper'

describe 'Admin views lessons' do
  it 'of a course' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg') 
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', docent: jorge)
    other_course = Course.create!(name: 'Rails', description: 'Um curso de Rails',
                            code: 'RAILS', price: 10,
                            enrollment_deadline: '22/12/2033', docent: jorge)
    Lesson.create!(name: 'Classes e Objetos', duration: 10, body: 'Uma aula de Ruby', course: course)
    Lesson.create!(name: 'Monkey Patch', duration: 20, body: 'Uma aula sobre monkey patch', course: course)
    Lesson.create!(name: 'Aula para não ver', duration: 40, body: 'Uma aula para não ver', course: other_course)

    visit course_path(course)

    expect(page).to have_text('Classes e Objetos')
    expect(page).to have_text('10 minutos')
    expect(page).to have_text('Monkey Patch')
    expect(page).to have_text('20 minutos')
    expect(page).to_not have_text('Aula para não ver')
    expect(page).to_not have_text('40 minutos')
  end

  xit 'and does not have lessons' do
    
  end

  xit 'and view content' do
    
  end
end