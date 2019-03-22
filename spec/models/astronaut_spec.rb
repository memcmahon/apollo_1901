require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe 'Class Methods' do
    before :each do
      @neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      @alan = Astronaut.create!(name: "Alan Shepard", age: 32, job: "Engineer")
      @buzz = Astronaut.create!(name: "Buzz Aldrin", age: 31, job: "Engineer")
      @capricorn4 = @neil.missions.create(title: "capricorn4", time_in_space: 3)
      @buzz.missions << @capricorn4
      @alan.missions << @capricorn4
      @apollo13 = @neil.missions.create(title: "Apollo 13", time_in_space: 3)
      @buzz.missions << @apollo13
      @gemini7 = @neil.missions.create(title: "Gemini 7", time_in_space: 3)
    end

    it '.average_age' do
      engineers = Astronaut.where(job: "Engineer")
      expect(engineers.average_age).to eq(31.5)
      expect(Astronaut.average_age.round(2)).to eq(33.33)
    end
  end

  describe "Instance Methods" do
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

    it '.sorted_missions' do
      expect(@neil.sorted_missions).to eq([@apollo13, @capricorn4, @gemini7])
    end
  end
end
