word_to_guess = File.readlines('words.txt').map { |word| word.strip }.sample

letters_successfully_guessed = []

lives = 7;

art = [
  <<-ART ,
/----
|   |
|
|
|
|
--------
  ART
  <<-ART ,
/----
|   |
|   O
|
|
|
--------
  ART
  <<-ART ,
/----
|   |
|   O
|   |
|
|
--------
  ART
  <<-ART ,
/----
|   |
|   O
|  /|
|
|
--------
  ART
  <<-ART ,
/----
|   |
|   O
|  /|\\
|
|
--------
  ART
  <<-ART ,
/----
|   |
|   O
|  /|\\
|  /
|
--------
  ART
  <<-ART ,
/----
|   |
|   O
|  /|\\
|  / \\
|
--------
  ART
]

loop do
	#Case for LOSING
	if lives <= 1
	  puts art[6]
	  puts "You lose!"
	  puts "The answer was " + "'" + word_to_guess + "'"
	  break
	end
	#Checking if guessed letter is contained in array of original word's characters
	cryptic_word = word_to_guess.chars.map do |character|
		if letters_successfully_guessed.include? character
	    character
		else
			"_" 
		end

	end.join(" ")

	#Case for WINNING
	if !cryptic_word.include?("_")
		puts "The answer is " + "'" + word_to_guess + "'" + "!"
		puts "You win!"
		break
	end

	#Handling lives/art
	# puts "You have #{lives} lives left."
	puts art[7 - lives]

	puts "This is your word:"
	puts cryptic_word

	puts "Guess a letter"
	guess = gets.strip

	if word_to_guess.include? guess
		puts "You guessed right!"
		letters_successfully_guessed << guess
	else
	 	puts "Wrong!"
	 	lives -= 1
	end
end