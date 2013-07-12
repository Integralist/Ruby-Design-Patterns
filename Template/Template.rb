#!/usr/bin/env ruby

# Our abstract class all other classes inherits from
class Wall
    def dimensions
        "I am #{length}ft. long and #{width}ft. wide!"
    end

    def made_from
        "I am made from #{material}!"
    end

    private

    def length
        30
    end
end

# We create new methods to handle the functionality not included in the base Template
# So in this example, our base template had a method called `dimensions` which interpolated
# some values but the base template didn't provide a value for one of the interpolated items
# So in the following class we define that missing method.
# Remember, our code never instantiates a new instance of the base template so it's OK that
# the base template is missing a `width` method which we implement/override in this class
class BrickWall < Wall
    private

    def width
        20
    end

    def material
        'brick'
    end
end

class ConcreteWall < Wall
    private

    def width
        20
    end

    def material
        'concrete'
    end
end

class WoodWall < Wall
    private

    def length
        10
    end

    def width
        20
    end

    def material
        'wood'
    end
end