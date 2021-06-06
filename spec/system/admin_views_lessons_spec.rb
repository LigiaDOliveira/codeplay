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
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg') 
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', docent: jorge)
    other_course = Course.create!(name: 'Rails', description: 'Um curso de Rails',
                            code: 'RAILS', price: 10,
                            enrollment_deadline: '22/12/2033', docent: jorge)

    user_login
    visit admin_course_path(course)

    expect(page).to have_text('Esse curso ainda não tem aulas cadastradas')
  end

  xit 'and view content' do
    user = User.create!(email: 'john.doe@test.com.br', password: '123456')
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg') 
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', docent: jorge)
    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 10,
                            content: 'Uma aula de Ruby', course: course)

    user_login
    visit admin_course_path(course)
    click_on lesson.name

    expect(page).to have_text(lesson.name)
    expect(page).to have_text("#{lesson.duration} minutos")
    expect(page).to have_text(lesson.content)
    expect(page).to have_link('Voltar', href: admin_course_path(course))
  end

  xit 'must be logged in to access through route' do
    jorge = Docent.create(name: 'Jorge', email: 'jorge@docent.com', 
                          bio: 'Um professor chamado Jorge')                
    jorge.profile_picture.attach(io: File.open('./spec/files/jorge-dazai.jpg'),filename: 'jorge-dazai.jpg') 
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', docent: jorge)
    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 10,
                            content: 'Uma aula de Ruby', course: course)

    visit admin_course_lesson_path(course, lesson)

    expect(current_path).to eq(new_user_session_path)
  end
end