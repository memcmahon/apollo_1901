require 'rails_helper'

RSpec.describe "Astronaut Index" do
  describe "As a visitor" do
    before :each do
      @neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      @alan = Astronaut.create!(name: "Alan Shepard", age: 32, job: "Engineer")
      @buzz = Astronaut.create!(name: "Buzz Aldrin", age: 31, job: "Engineer")
      @capricorn4 = @neil.missions.create(title: "Capricorn 4", time_in_space: 3)
      @buzz.missions << @capricorn4
      @alan.missions << @capricorn4
      @apollo13 = @neil.missions.create(title: "Apollo 13", time_in_space: 3)
      @buzz.missions << @apollo13
      @gemini7 = @neil.missions.create(title: "Gemini 7", time_in_space: 3)
    end
    it "shows astro information (name, age, job)" do

      visit astronauts_path

      within "#astronaut-#{@neil.id}" do
        expect(page).to have_content(@neil.name)
        expect(page).to have_content("Age: #{@neil.age}")
        expect(page).to have_content("Job: #{@neil.job}")
        expect(page).to have_content("Total Space Time: 9")
      end

      within "#astronaut-#{@alan.id}" do
        expect(page).to have_content(@alan.name)
        expect(page).to have_content("Age: #{@alan.age}")
        expect(page).to have_content("Job: #{@alan.job}")
        expect(page).to have_content("Total Space Time: 3")

      end

      within "#astronaut-#{@buzz.id}" do
        expect(page).to have_content(@buzz.name)
        expect(page).to have_content("Age: #{@buzz.age}")
        expect(page).to have_content("Job: #{@buzz.job}")
        expect(page).to have_content("Total Space Time: 6")
      end
    end

    it "shows avg age of all astronauts" do
      visit astronauts_path

      expect(page).to have_content("Average Age: 33.33")
    end

    it 'shows missions in alph order for each astro' do
      visit astronauts_path

      within "#astronaut-#{@neil.id}" do
        expect(page.all('li')[0]).to have_content(@apollo13.title)
        expect(page.all('li')[1]).to have_content(@capricorn4.title)
        expect(page.all('li')[2]).to have_content(@gemini7.title)
      end

      within "#astronaut-#{@alan.id}" do
        expect(page.all('li')[0]).to have_content(@capricorn4.title)
      end

      within "#astronaut-#{@buzz.id}" do
        expect(page.all('li')[0]).to have_content(@apollo13.title)
        expect(page.all('li')[1]).to have_content(@capricorn4.title)
      end
    end
  end
end
