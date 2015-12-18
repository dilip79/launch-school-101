require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
p MESSAGES

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

def operation_to_message(operation)
  case operation
  when '1'
    'ADDING'
  when '2'
    'SUBTRACTING'
  when '3'
    'MULTIPLYING'
  when '4'
    'DIVIDING'
  end
end

loop do
  prompt(MESSAGES['welcome'])
  name = ''
  loop do
    name = Kernel.gets().chomp()
    if name.empty?()
      prompt(MESSAGES['valid_name'])
    else
      break
    end
  end

  prompt("hi #{name}!")
  number1 = ''
  loop do
    prompt("Enter your first number")
    number1 = Kernel.gets().chomp()
    if valid_number(number1)
      break
    else
      prompt("It doesn't look like valid number!")
    end
  end

  number2 = ''
  loop do
    prompt("Enter your second number")
    number2 = Kernel.gets().chomp()
    if valid_number(number2)
      break
    else
      prompt("It doesn't look like valid number!")
    end
  end

  operator_prompt = <<-MSG
  what operation you want to perform
  1) ADD
  2) SUBTRACT
  3) MULTIPLY
  4) DIVIDE
  MSG
  prompt("#{operator_prompt}")
  operation = ''
  loop do
    operation = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt("Must choose 1, 2, 3, 4")
    end
  end
  prompt("#{operation_to_message(operation)} the numbers")
  result = case operation
           when '1'
             number1.to_f + number2.to_f
           when '2'
             number1.to_f - number2.to_f
           when '3'
             number1.to_f * number2.to_f
           when '4'
             number1.to_f / number2.to_f
           end
  prompt("The result is #{result}")
  prompt("would you like to perform another calculation(Type Y to calculate)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
prompt("Thanks for using calculator")
