class BankAccount
    def initialize(starting_balance=0)
        @balance = starting_balance
    end

    def deposit(amount)
        @balance += amount
    end

    def balance
        @balance
    end
end

class AccountProxy
    def initialize(real_account)
        @subject = real_account
    end

    def method_missing(name, *args)
        puts("Delegating #{name} message to subject.")
        @subject.send(name, *args)
    end
end

ap = AccountProxy.new( BankAccount.new(100) )
ap.deposit(25)
puts("account balance is now: #{ap.balance}")