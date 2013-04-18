class Singleton
    def write_message msg
        puts msg
    end

    @@instance = Singleton.new

    def self.instance
        return @@instance
    end

    private_class_method :new # the `new` method may be a special method but it's still just a class method that we can set the visibility of
end

object = Singleton.instance
object.write_message 'Hello'

object_new = Singleton.new
object_new.write_message 'Hello again' # private method `new' called for Singleton:Class (NoMethodError)