# mastermind.rb

class Codemaker
  
  
    def initialize(code)
      
      @code = code # array of 6 digits
      @learned = [] # for computer guessing Method
      @learned_index = 0
    end
   
    
    def feedback(code, guess)
      
      # needs to output to user array feedback
      feedback_array = []
      i = 0
      
      # loop while index < guess array
      while i < guess.length
      
        # if color/position is correct push (1) to the feedback_array
        if code[i] == guess[i]
          
          feedback_array.push(1)
          i += 1
        
        # if color is correct but position is wrong push 0 to the array
        elsif code.include?(guess[i])
        
          feedback_array.push(0)
          i += 1
        
        # if color/position is wrong push blank array position  
        else
          
          feedback_array.push(' ')
          i += 1
        end
        
      end # while loop ends
      
      return feedback_array
      
    end # Ends feedback Method
    
  
    # Creates another method that takes in the feedback and original guess, and outputs a new guess to be used on the next turn
    def educated(feedback, guess)
      
      i = 0
      index = 0
      current_selection = [0,1,2,3]
  
      while index < 3 # Checks for unlearned digits 
        
        if feedback[i] == 0
          
          if @learned.include?(guess[index])
          
            i += 1
          
          else
          
            @learned.push(guess[index])
            i += 1
  
            p @learned
  
          end
  
  
        else
  
          i += 1
  
        end
  
        index += 1
        
      end # Adds to @learned array for generating new computer guess
      
  
      i = 0 # Resets i
      
      while i < 4
      
        if feedback[i] == 1
          
          guess[i] = guess[i]
          i += 1  
        
        elsif feedback[i] == 0 
          
          if @learned_index < @learned.length
  
            guess[i] = @learned[@learned_index]
            i += 1
            @learned_index += 1 # increase learned_index counter
  
          else
  
            guess[i] = current_selection[rand(4)]
            i += 1
  
          end
  
  
        else # Pushes overall random integer
          
          guess[i] = rand(4)
          i += 1
          
        end
        
      end # Ends while loop
  
      # remove @learned[@learned_index] digit from 0..3 array selection
      current_selection.delete(@learned[@learned_index])
  
      return guess # return new guess to break code
      
    end # Ends Educated Method
    
    
    def code # Reader - Delete if unnecessary
    
      @code
    
    end
    
    
  end # ends Codemaker class
  
  
  
  
  # START GAME
  # Method that creates random 6 digit array
  
  code_array = []
  guess_array = []
  
  choice = -1
  
  
  turns = 0 # Total turns allowed per game will be 12 Total
  
  
  def generate_code(code_array) # Computer Auto-Generates code
    
    i = 0
    
    while i < 4
    
      code_array.push(rand(4))  
      i += 1
    
    end
    
    return code_array
    
  end
  
  
  
  def define_code(code_array) # User chooses code
    
    puts "Please input a digit between 0 and 3 inclusive."
    
    i = 0
    
    while i < 4
    
      puts "Input guess: ##{i + 1}"
      code = gets.chomp.to_i
      
      if code < 4
        code_array.push(code)
        i += 1
      else
        
        puts "Please try again, input a digit between 0 and 3 inclusive."
        
      end
      
      p code_array
      
    end
    
  end
  
  
  
  # PART 1 - initialize Codemaker with code_array to be guessed
  # Create statement that determines whether to use computer or user as CodeMaker
  
  while choice < 0 || choice > 1
  
    puts "Please input 0 if you want the computer to be the CodeMaker or input 1 if you would like to be the CodeMaker"
  
    choice = gets.chomp.to_i
  
  end
  
  
  if choice == 0
  
    generate_code(code_array) # Computer is CodeMaker
  
  end
  
  
  if choice == 1
    
    define_code(code_array) # Person is Codemaker
  
  end
  
  current_code = Codemaker.new(code_array) # New Object using code_array
  
  p code_array
  puts "The CodeMaker has created the cipher...TIME TO BREAK IT!"
  
  
  
  # GAME LOOP STARTS
  # PART 2a - Make guess (USER)
  if choice == 0
    
    while turns < 12
    
      puts "Please input a digit between 0 and 3 inclusive."
  
      guess_array =[]    
      i = 0
      
      while i < 4
      
        puts "Input guess: ##{i + 1}"
        guess = gets.chomp.to_i
        
        if guess < 4
          guess_array.push(guess)
          i += 1
        else
          
          puts "Please try again, input a digit between 0 and 3 inclusive."
          
        end
        
        p guess_array
        
      end
      
      
      # PART 2b - Receive feedback on guess
      puts "[1] - means that number/position is correct"
      puts "[0] - means that number is correct and it is contained in the array, but the position is wrong. Duplicates ARE NOT accounted for in feedback."
      puts "[' '] - means that the input is totally off"
      
      puts "CodeMaker feedback: "
      
      p feedback = current_code.feedback(code_array, guess_array) # Returns feedback to user
      p guess_array
      
      if feedback.all?(1)
        
        puts "GAME OVER YOU WIN"
        turns = 12 # end game
        
      end
      
      
      turns += 1
    
    end # Ends 12 turn cycle
  
    if feedback.any?(0) || feedback.any?(" ")
      
      puts "GAME OVER YOU LOST"
    
    end
  
  end
  
  
  # PART 2a - Make guess (COMPUTER)
  if choice == 1 # TESTING
    
    guess_array =[]    
    i = 0
      
      while i < 4 
      
        guess = rand(3)
        
        guess_array.push(guess)
        i += 1
        
      end    
  
    while turns < 12
    
      puts "Turn ##{turns + 1}\n"
  
      p "code_array => #{code_array}"
      p "guess_array => #{guess_array}"
      # p "pre-feedback => #{feedback}"
      
      
      feedback = current_code.feedback(code_array, guess_array) # TESTING
      # p "post-feedback => #{feedback}"
      guess_array = current_code.educated(feedback, guess_array) # TESTING
    
    
      p "new_guess => #{guess_array}"
  
      if feedback.all?(1)
        
        puts "GAME OVER YOU WIN"
        turns = 12 # end game
        
      end
    
      turns += 1
    
    end
    
    if feedback.any?(0) || feedback.any?(" ")
      
      puts "GAME OVER YOU LOST"
    
    end
  
  end
  