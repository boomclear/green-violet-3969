require "rails_helper"

RSpec.describe Airline, type: :model do
  describe "relationships" do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end
  describe "instance methods" do
    it "adult_passengers" do
      airline = Airline.create!(name: "Spirit")
      airline2 = Airline.create!(name: "Delta")
    
      flight1 = Flight.create!(number: "1782", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno", airline: airline)
      flight2 = Flight.create!(number: "23425", date: "08/03/20", departure_city: "Shreveport", arrival_city: "Dallas", airline: airline)
      flight3 = Flight.create!(number: "1234", date: "08/03/20", departure_city: "Jacksonville", arrival_city: "Boulder", airline: airline2)

      pass1 = Passenger.create!(name: "Austin", age: 23)
      pass2 = Passenger.create!(name: "Jimmy", age: 23)
      pass3 = Passenger.create!(name: "Garrett", age: 13)
      pass4 = Passenger.create!(name: "Julian", age: 23)

      flight_passenger1 = FlightPassenger.create!(passenger: pass1, flight: flight1)
      flight_passenger1 = FlightPassenger.create!(passenger: pass1, flight: flight2)
      flight_passenger2 = FlightPassenger.create!(passenger: pass2, flight: flight1)
      flight_passenger3 = FlightPassenger.create!(passenger: pass3, flight: flight1)
      flight_passenger4 = FlightPassenger.create!(passenger: pass4, flight: flight3)

      expect(airline.adult_passengers).to eq([pass1, pass2])
    end
  end
end
