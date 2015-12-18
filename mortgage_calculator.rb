

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number(num)
  integer?(num) || float?(num)
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  /^\d*\.?\d*$/.match(num)
end

loop do
  prompt("Welcome to Mortgage calculator")
  prompt("<---------------------------->")
  amount = ''
  loop do
    prompt("Enter your Loan amount")
    amount = Kernel.gets().chomp()
    if amount.empty?() || amount.to_f() < 0
      prompt("Please enter a positive number!")
    else
      break
    end
  end

  interest_rate = ''
  loop do
    prompt("Enter your Interest rate")
    prompt("It should be 4 for 4% or 12.5 for 12.5%")
    interest_rate = Kernel.gets().chomp()
    if interest_rate.empty?() || interest_rate.to_f < 0
      prompt("Must enter a positive number!")
    else
      break
    end
  end

  years = ''
  loop do
    prompt("Enter your loan duration( in Years)")
    years = Kernel.gets().chomp()
    if years.empty?() || years.to_f < 0
      prompt("Must enter a positive number!")
    else
      break
    end
  end

  annual_interest_rate = interest_rate.to_f() / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = years.to_i * 12
  monthly_payment = amount.to_f() *
                    (monthly_interest_rate /
                    (1 - (1 + monthly_interest_rate)**-months.to_i()))
  prompt("Your monthly payment is #{format('%02.4f', monthly_payment)}")
  prompt("Another calculation? (Type Y to calculate)")
  answer = Kernel.gets().downcase()
  break unless answer.start_with?('y')
end
prompt("Thanks for using mortgage calculator")
