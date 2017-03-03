require 'terminal-table'
require 'artii'
require 'date'
require 'colorize'

# Starting point for array as nil
@details = []


  #Adding fancy heading
  exit = false
  a = Artii::Base.new :font => 'big'
  puts a.asciify('Paying Bills On Time')



  def clean_system
    system "clear"
  end

  #Start of menu option
  def name
    puts "Please enter your first name?"
    @first_name = gets.chomp
    puts "Please enter your surname?"
    @last_name = gets.chomp
  end

  # def color(difference_in_days)
  #   if difference_in_days <= 14
  #     return "#{difference_in_days}.colorize(:red)"
  #   elsif difference_in_days > 14 && difference_in_days <= 30
  #     return "#{difference_in_days}.colorize(:blue)"
  #   else
  #     return "#{difference_in_days}.colorize(:orange)"
  #   end
  # end

  #Enter details for bills
  def add_bill
    puts "Enter business to be paid?"
    @business = gets.chomp
    puts "What is the bill for?"
    @type = gets.chomp
    puts "How much is the bill?"
    @amount = gets.chomp
    puts "When is the due date in format YYYY/MM/DD?"
    date_str = gets.chomp
    #date = Date.parse(date)
    @date = Date.parse(date_str)
    @now = Date.today
    difference_in_days = (@date - @now).to_i
    #difference_in_days = (difference_in_days/365.25).to_i
    puts "Do you wish to enter another bill?"
    puts " 1 for yes, 2 for no"
    @input = gets.chomp

    puts "*" * 60
    puts
    puts "Bill has been added successfully"
    puts


    #Pushing all inputs to the array
    @details.push([@business, @type, @amount, @date, difference_in_days])

    if @input == '1'
      add_bill
    elsif @input == '2'
      menu_options_2
    end
  end

  #Generate table based on condition for 4th element within a single element within an array
  def generate_table_rows(details)
      table_rows = []
      @details.each do |detail|
        color = :blue
        if detail[4] <= 14
          color = :red
        elsif detail[4] <= 30
          color = :yellow
        end

        table_rows.push [detail[0], detail[1], detail[2], detail[3], detail[4].to_s.colorize(color)]
      end
        return table_rows.sort_by {|a,b,c,d,e| e}
    end


  #Format for output from Github : Teminal-table
  def table_of_bills
    table = Terminal::Table.new(title: "Bills needing Attention", headings: ['Name of Business', 'Utility', 'Amount', 'Due Date YYYY/MM/DD', 'Days Left to Pay'], rows: generate_table_rows(@details))
  end


  #The starting menu.
  def menu_options
    puts
    puts "At present there are #{@details.length} bills to be viewed."
    puts
    puts "1. Enter a bill"
    puts "2. Exit system"
    options = gets.chomp
    if options == '1'
      name
      add_bill
    elsif options == '2'
      exit
    else
      puts "Please select options: 1 or 2"
      menu_options
    end
  end

  def menu_options_2
    puts
    puts "At present there are #{@details.length} bills to be viewed."
    puts
    puts "1. Enter another bill"
    puts "2. See all bills"
    puts "3. Exit system"
    options = gets.chomp
    if options == '1'
      add_bill
    elsif options == '2'
      clean_system
      exit = false
      a = Artii::Base.new :font => 'big'
      puts a.asciify('Paying Bills On Time')
      puts
      puts
      puts "Personalised bills for #{@first_name} #{@last_name}"
      puts "Today's Date is #{@now}"
      puts
      puts table_of_bills
      menu_options_2
    elsif options == '3'
      exit
    else
      puts "Please select options: 1, 2, or 3"
      menu_options
    end
  end


  menu_options
