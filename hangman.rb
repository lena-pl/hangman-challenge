word_to_guess = File.readlines('words.txt').map { |word| word.strip }.sample

# letters = word_to_guess.chars
#  cryptic_word = letters.map do |letter| 
# 	"_ "
# end


letters_successfully_guessed = []

lives = 7;

loop do
	cryptic_word = word_to_guess.chars.map do |character|
		if letters_successfully_guessed.include? character
	    character

		elsif lives <= 0
			puts "You lose!".
		break

		else
			"_" 
		end

	end.join(" ")
	puts "You have #{lives} lives left."
	puts "This is your word:"
	puts cryptic_word

	puts "Guess a letter"
	guess = gets.strip

	# if word_to_guess.include? guess
	# 	lives -= 1
	# 	letters_successfully_guessed << guess
	#  else
	#  	puts "Guess again!"
	#  	lives_remaining -= 1
	# end

	if word_to_guess.include? guess
		puts "You guessed right!"
		letters_successfully_guessed << guess
	unless cryptic_word.include?("_")
		puts "You're done!"
		end
	 else
	 	puts "Guess again!"
	 	lives -= 1
	end
end