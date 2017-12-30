local BankAccount = {}

function BankAccount:new()
    local new_bank_account = {current_balance=0, closed=false}
    setmetatable(new_bank_account, self)
    self.__index = self
    return new_bank_account
end

function BankAccount:balance()
    return self.current_balance
end

function BankAccount:deposit(amount)
    assert(amount > 0 and not self.closed)
    self.current_balance = self.current_balance + amount
end

function BankAccount:withdraw(amount)
    assert(0 < amount and amount < self.current_balance and not self.closed)
    self.current_balance = self.current_balance - amount
end

function BankAccount:close()
    self.closed = true
end

return BankAccount
