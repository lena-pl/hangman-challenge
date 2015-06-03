word_to_guess = File.readlines('words.txt').map { |word| word.strip }.sample

# letters = word_to_guess.chars
#  cryptic_word = letters.map do |letter| 
# 	"_ "
# end

letters_successfully_guessed = []


letters_successfully_guessed = []

loop do
	cryptic_word = word_to_guess.chars.map do |character|
	  if letters_successfully_guessed.include? character
	    character
	  else
	    "_" 
	  end
	end.join(" ")
	puts "This is your word:"
	puts cryptic_word

	puts "Guess a letter"
	guess = gets.strip

	if word_to_guess.include? guess
		puts "You guessed right!"
		letters_successfully_guessed << guess
	elsif !cryptic_word.include? "_"
		puts "You're done!"
		break
	 else
	 	puts "Guess again!"
	end
end