require 'singleton'

class SingletonRequire
    include Singleton # the benefit of this version is it lazy loads when user actually requests instance

    def write_message msg
        puts msg
    end
end

object = SingletonRequire.instance
object.write_message 'Hello'

object_new = SingletonRequire.new
object_new.write_message 'Hello again' # private method `new' called for SingletonRequire:Class (NoMethodError)