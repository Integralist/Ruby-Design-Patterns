class WaterLily
    def initialize name
        @name = name
    end

    def grow
        puts("The water lily #{@name} floats, soaks up the sun, and grows")
    end
end

class Frog
    def initialize name
        @name = name
    end
    
    def eat
        puts("Frog #{@name} is eating.")
    end
    
    def speak
        puts("Frog #{@name} says Crooooaaaak!")
    end

    def sleep
        puts("Frog #{@name} doesn't sleep; he croaks all night!")
    end
end

class Tree
    def initialize name
        @name = name
    end

    def grow
        puts("The tree #{@name} grows tall")
    end
end

class Tiger
    def initialize name
        @name = name
    end
    
    def eat
        puts("Tiger #{@name} eats anything it wants.")
    end
    
    def speak
        puts("Tiger #{@name} Roars!")
    end

    def sleep
        puts("Tiger #{@name} sleeps anywhere it wants.")
    end
end

class Factory
    def initialize plant_class, animal_class
        @plant_class  = plant_class
        @animal_class = animal_class
    end

    def new_plant name
        @plant_class.new name
    end

    def new_animal name
        @animal_class.new name
    end
end

class Habitat
    attr_accessor :plants, :animals

    def initialize number_plants, number_animals, factory
        @plants  = []
        @animals = []
        @factory = factory

        number_plants.times do |i|
            plant = @factory.new_plant "Plant#{i}"
            @plants << plant
        end

        number_animals.times do |i|
            animal = @factory.new_animal "Animal#{i}"
            @animals << animal
        end
    end
end

pond_factory   = Factory.new(WaterLily, Frog)
jungle_factory = Factory.new(Tree, Tiger)

pond   = Habitat.new(2, 4, pond_factory)
jungle = Habitat.new(1, 4, jungle_factory)

p pond.plants[0].grow
p pond.plants[1].grow

p jungle.animals[0].eat
p jungle.animals[0].speak
p jungle.animals[0].sleep

p jungle.animals[1].eat
p jungle.animals[1].speak
p jungle.animals[1].sleep

p jungle.animals[2].eat
p jungle.animals[2].speak
p jungle.animals[2].sleep

p jungle.animals[3].eat
p jungle.animals[3].speak
p jungle.animals[3].sleep