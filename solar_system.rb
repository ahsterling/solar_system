class Planet
  #The rate of solar rotation is expressed in earth years
  attr_accessor :name, :mass_in_kg, :dist_sun, :num_of_moons, :rate_of_solar_rotation

  def initialize(planet_hash)
    @name = planet_hash[:name]
    @mass_in_kg = planet_hash[:mass_in_kg]
    @dist_sun = planet_hash[:dist_sun]
    @num_of_moons = planet_hash[:num_of_moons]
    @rate_of_solar_rotation = planet_hash[:rate_of_solar_rotation]
  end

  #def find_rate_of_rotation(hours, minutes, seconds)
  #  seconds = seconds.to_i
  #  mins_in_sec = minutes.to_i * 60
  #  hours_in_sec = hours.to_i * 60 * 60
  #  @rate_of_solar_rotation = seconds + mins_in_sec + hours_in_sec
  #end

end

class SolarSystem
  attr_accessor :planets, :formation_date, :current_planet

  def initialize
    @planets = []
    @formation_date = 0
  end

  def add_planet(name)
    planet = Planet.new(name)
    @planets.push(planet)
  end

  def find_local_year(planet)
    #form_date_in_days = @formation_date
    #local_year_in_days = (2014 - (form_date_in_days) / planet.rate_of_solar_rotation)
    #local_year = local_year_in_days /
    local_year = (100 - @formation_date) / planet.rate_of_solar_rotation
    return local_year
  end

  def show_planets
    puts "The planets in your solar system are: "
    puts
    @planets.each do |p|
      puts p.name
      puts "Mass: #{p.mass_in_kg} kg"
      puts "Distance from sun: #{p.dist_sun} miles"
      puts "This planet has #{p.num_of_moons} moons."
      puts
    end
  end

  def start
    puts "Which planet would you like to explore? Choose one of the planets below."
    puts
    @planets.each do |p|
      puts p.name
    end
    puts
    print "> "
    input = gets.chomp
    @planets.each do |p|
        if p.name.include? input
          @current_planet = p
        end
    end
    puts
    explore_planet(@current_planet)
    #puts "Mass: #{@current_planet.mass_in_kg} kg"
    #puts "Distance from sun: #{@current_planet.dist_sun} miles"
    #puts "This planet has #{@current_planet.num_of_moons} moons."
    #puts
  end

  def explore_planet(planet)
    prompt = """What would you like to know about this planet?
1. Mass
2. Distance from the sun
3. Number of Moons
4. Rate of solar rotation
5. The local year of the planet

Please type 1, 2, 3, 4, or 5

To go back to the planet menu, type \"planet menu\".
To exit completely, type \"exit\".
"""
    puts prompt
    print "> "
    input = gets.chomp
    while input
      if input == "1"
        puts "\n#{planet.name}'s mass is #{planet.mass_in_kg}."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "2"
        puts "\n#{planet.name} is #{planet.dist_sun} miles from the sun."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "3"
        puts "\n#{planet.name} has #{planet.num_moons} moons."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "4"
        puts "\n#{planet.name}'s rate of solar rotation is #{planet.rate_of_solar_rotation} earth years."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "5"
        puts "\nThe local year on #{planet.name} is #{planet.find_local_year}."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "exit"
        puts "Goodbye!"
        exit
      elsif input == "planet menu"
        start
      else
        puts "Sorry, I didn't understand that.  Please type 1, 2, 3, 4, or 5 to choose an option."
        input = gets.chomp
      end
    end

  end

  def our_solar_system
    add_planet(name: "Mercury", mass_in_kg: 328.5e21, dist_sun: 35_980_000, num_of_moons: 0, rate_of_solar_rotation: 10)
    add_planet(name: "Venus", mass_in_kg: 4.867e24, dist_sun: 67_240_000, num_of_moons: 0)
    add_planet(name: "Earth", mass_in_kg: 5.972e24, dist_sun: 92_960_000, num_of_moons: 1, rate_of_solar_rotation: 1)
    add_planet(name: "Mars", mass_in_kg: 639e21, dist_sun: 141_600_000, num_of_moons: 2)
    add_planet(name: "Jupiter", mass_in_kg: 1.898e27, dist_sun: 483_800_000, num_of_moons: 50)
    add_planet(name: "Saturn", mass_in_kg: 568.3e24, dist_sun: 890_700_000, num_of_moons: 53)
    add_planet(name: "Uranus", mass_in_kg: 86.81e24, dist_sun: 1_787_000_000, num_of_moons: 27)
    add_planet(name: "Neptune", mass_in_kg: 102.4e24, dist_sun: 2_798_000_000, num_of_moons: 13)
  end

end

s = SolarSystem.new
s.our_solar_system

puts
s.show_planets
puts "Earth year is: #{s.find_local_year(s.planets[2])} "
puts "Local year is: #{s.find_local_year(s.planets[0])} "

s.start
