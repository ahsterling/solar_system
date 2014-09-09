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

end

class SolarSystem
  attr_accessor :planets, :formation_date, :current_planet

  def initialize
    @planets = []
    @formation_date = -4.5e9 + 2014
    @current_year = 2014
    our_solar_system
  end

  def add_planet(name)
    planet = Planet.new(name)
    @planets.push(planet)
  end

  def between_planets(planet1, planet2)
    dist = planet1.dist_sun - planet2.dist_sun
    dist = dist.to_s
    if dist[0] == "-"
      dist = dist.delete "-"
      dist.to_i
    else
      dist.to_i
    end
    return dist

  end

  def find_local_year(planet)
    local_year = ((@current_year - @formation_date) / planet.rate_of_solar_rotation)
    return local_year.to_i
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
    puts "To exit, type \"exit\""
    puts
    @planets.each do |p|
      puts p.name
    end
    puts
    print "> "
    input = gets.chomp
    if input == "exit"
      puts "Goodbye!"
      exit
    end
    @planets.each do |p|
        if p.name.include? input
          @current_planet = p
        end
    end
    puts
    explore_planet(@current_planet)

  end

  def explore_planet(planet)
    prompt = """What would you like to know about this planet?
1. Mass
2. Distance from the sun
3. Number of Moons
4. Rate of solar rotation
5. The local year of the planet
6. The distance to another planet

Please type 1, 2, 3, 4, 5, or 6

To go back to the planet menu, type \"planet menu\".
To exit completely, type \"exit\".
"""
    puts prompt
    print "> "
    input = gets.chomp
    while input
      if input == "1"
        puts "\n#{planet.name}'s mass is #{planet.mass_in_kg} kg."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "2"
        puts "\n#{planet.name} is #{planet.dist_sun} miles from the sun."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "3"
        puts "\n#{planet.name} has #{planet.num_of_moons} moons."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "4"
        puts "\n#{planet.name}'s rate of solar rotation is #{planet.rate_of_solar_rotation} earth years."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "5"
        puts "\nThe local year on #{planet.name} is #{find_local_year(planet)}."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "6"
        puts "Choose a planet below to calculate #{planet.name}'s distance from it:"
        puts
        @planets.each do |p|
          puts p.name
        end
        puts
        print "> "
        other_planet = gets.chomp
        if other_planet == "exit"
          puts "Goodbye!"
          exit
        end
        @planets.each do |p|
            if p.name.to_s.include? other_planet.to_s
              other_planet = p
            end
        end
        puts "#{planet.name} is #{between_planets(planet, other_planet)} miles from #{other_planet.name}."
        puts
        puts prompt
        input = gets.chomp
      elsif input == "exit"
        puts "Goodbye!"
        exit
      elsif input == "planet menu"
        puts
        start
      else
        puts "Sorry, I didn't understand that.  Please type 1, 2, 3, 4, or 5 to choose an option."
        input = gets.chomp
      end
    end

  end

  def our_solar_system
    add_planet(name: "Mercury", mass_in_kg: 328.5e21, dist_sun: 35_980_000, num_of_moons: 0, rate_of_solar_rotation: 0.24)
    add_planet(name: "Venus", mass_in_kg: 4.867e24, dist_sun: 67_240_000, num_of_moons: 0, rate_of_solar_rotation: 0.62)
    add_planet(name: "Earth", mass_in_kg: 5.972e24, dist_sun: 92_960_000, num_of_moons: 1, rate_of_solar_rotation: 1)
    add_planet(name: "Mars", mass_in_kg: 639e21, dist_sun: 141_600_000, num_of_moons: 2, rate_of_solar_rotation: 1.88)
    add_planet(name: "Jupiter", mass_in_kg: 1.898e27, dist_sun: 483_800_000, num_of_moons: 50, rate_of_solar_rotation: 11.86)
    add_planet(name: "Saturn", mass_in_kg: 568.3e24, dist_sun: 890_700_000, num_of_moons: 53, rate_of_solar_rotation: 29.45)
    add_planet(name: "Uranus", mass_in_kg: 86.81e24, dist_sun: 1_787_000_000, num_of_moons: 27, rate_of_solar_rotation: 84.3)
    add_planet(name: "Neptune", mass_in_kg: 102.4e24, dist_sun: 2_798_000_000, num_of_moons: 13, rate_of_solar_rotation: 164.79)
  end

end

s = SolarSystem.new
s.start
