module SingletonModule
    def self.write_message msg
        puts msg
    end
end

SingletonModule.write_message 'Hello'
SingletonModule.write_message 'Hello again'