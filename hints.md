[Iteration #1 Hints](#1)
----

We're trying to take a word, like "art", and turn it into a bunch of underscores, separated by spaces.

`"art"` is a string. It's a series of characters. We want to show a series of underscores, the same number as there are characters in our string.

We can get the number of characters in our string with `art.length`. How might we make a string of underscores of the same length?

In Ruby, you can multiply a string by a number, and you'll get that string repeated that many times. Let's test that out in `irb`.

```
$ irb
[1] irb(main)> "_" * 5
=> "_____"
```

That's a good start! So we can get the right number of underscores with `"_" * "art".length`.

Let's add that to our program and test it out.

```ruby
puts "_" * word_to_guess.length
```

Now run `ruby hangman.rb`. It should show a bunch of underscores, the same length as the word. One problem though; there are no spaces in between! Think for a moment, how might you put a space between each underscore?


```ruby
puts "_ " * word_to_guess.length
```
(Note the space after the underscore in the string.)

[Iteration #2 Hints](#2)
----

So, in this iteration, we're going to let our users guess a letter.

I like to think about the plain english explanations of how my program works. It's called pseudocode, and it's a great way to separate your understanding of how a program works with your understand of how you will implement it.

Ignoring everything but displaying the word and guessing, here's my pseudocode for hangman.

```
Start
Pick a random word for the user to guess
Loop
  Display the word to guess (with underscores for the letters not yet guessed)

  Ask the user to guess a letter

  If the user guesses correctly
    Reveal the letter
```

So, "Ask the user to guess a letter".

We can get input from the user by using `gets`. We have to `strip` the newline character off the end of the string it returns however.

```ruby

letter_guessed = gets.strip

```

"If the user guesses correctly"
We can check this by checking if the `word_to_guess` includes our `letter_guessed`.

```ruby
if word_to_guess.include? letter_guessed
  puts "You guessed right!"
end
```

At this point, we're going to need to add a loop if you haven't already.

The most simple way to do this in Ruby with a `loop do`.

Like so:

```ruby
loop do
  # code that will run over and over again
  puts "All work and no play makes jack a dull boy"
end
```

You can try run that code above. If your computer ends up in an infinite loop, you can hit `ctrl+c` to exit the program.

You can stop the loop inside of the program using `break`. This will exit the loop, and continue after the `end`.

Now, "Display the word to guess (with underscores for the letters not yet guessed)"

There are a few things going on here. Think about what we might need to do so that we can show the letters the users have correctly guessed, and underscores for the rest.

* Keep track of the letters the user correctly guessed
* Change what we show for each character in the word based on if they have guessed that letter or not

So, we can keep track of the letters our user has correctly guessed with an array.

Add this to the top of your code, outside of the loop:

```ruby
letters_successfully_guessed = []
```

And inside of the loop, where you check if the guess was correct:
```ruby
if word_to_guess.include? letter_guessed
  letters_successfully_guessed << letter_guessed
end
```

Now, we have an array that has each successful letter guessed added to it.

Now things get a little tricky. When we want to display the word, we have to conditionally display either an underscore or the character depending on if the user has sucesfully guessed it.

If you are using the `"_ " * word_to_guess.length` code I showed in the first hints section, don't be alarmed that we're changing it now.

It's easiest to think about this if we do it on a character by character basis.

Paste in each of the following iterations of code, run your program, and see what happens.

```ruby
puts word_to_guess.chars.inspect
```

```ruby
puts word_to_guess.chars.map { |character| character }.inspect
```

```ruby
puts word_to_guess.chars.map { |character| "_" }.inspect
```

```ruby
puts word_to_guess.chars.map { |character| "_" }.join(" ")
```

There's a fair bit going on in the above code, so try and look at the differences between each line and what it changes.

`word_to_guess.chars` returns the characters in the string as an array. `"art".chars => ["a", "r", "t"]`

`["a", "r", "t"].map { |character| character }` actually does nothing. You `map` over an array with a piece of code (in ruby they're called blocks). `map` returns a new array, with the result of the block for each element. If that seems confusing, that's okay. It's easier to understand if you play around with it.

```irb
[1] irb(main)> [1, 2, 3].map { |number| number * 2 }
=> [2, 4, 6]
[2] irb(main)> ["apple", "banana"].map { |word| word.upcase }
=> ["APPLE", "BANANA"]
[3] irb(main)> ["apple".upcase, "banna".upcase]
=> ["APPLE", "BANANA"]
```

So `["a", "r", "t"].map { |character| "_" }` will return `["_", "_", "_"]`. Line 3 shows the equvalent operation performed without the use of map.

Finally, we do a `["_", "_", "_"].join(" ")`. This turns the array into a string, with a space between each character. `"_ _ _"`.

Now, for the fun part. Only showing underscores for the letter not guessed. This is what the code looks like:

```ruby
word_to_display = word_to_guess.chars.map do |character|
  if letters_successfully_guessed.include? character
    character
  else
    "_" 
  end
end.join(" ")

puts word_to_display
```

So, for every character in the word, we check if they've successfully guessed it in the past, and return the character or an underscore otherwise.

[Iteration #3 Hints](#3)
----

Now we want to keep track of our user's lives. Once again, we're going to need a varariable outside of our loop to keep track.

`lives_remaining = 7`

Let's display that to the user every time before they guess.

```ruby
puts "Lives remaining: #{lives_remaining}"
```

We want to make it that when the user guesses a letter that isn't in the word, that number goes down.

```ruby
if word_to_guess.include? letter_guessed
  letters_successfully_guessed << letter_guessed
else
  lives_remaining -= 1
end
```

[Iteration #4 Hints](#4)
-----

Now we want to add our victory and loss conditions. This is where we'll exit the loop.

After our logic for guessing, let's check if the game is over. Let's start with winning. We know the user has won when all of the letters in the `word_to_guess` are in the `letters_successfully_guessed` array.

We can check this by subtracting the `letters_successfully_guessed` from `word_to_guess.chars`. Quick demo:

```irb
$ irb
[1] pry(main)> ["a", "b", "c"] - ["a", "b"]
=> ["c"]
[2] pry(main)> word_to_guess = "art"
=> "art"
[3] pry(main)> letters_successfully_guessed = ["a", "r"]
=> ["a", "r"]
[4] pry(main)> word_to_guess.chars - letters_successfully_guessed
=> ["t"]
[5] pry(main)> (word_to_guess.chars - letters_successfully_guessed).any?
=> true
[6] pry(main)> letters_successfully_guessed = ["a", "r", "t"]
=> ["a", "r", "t"]
[7] pry(main)> (word_to_guess.chars - letters_successfully_guessed).any?
=> false
```

Our code:

```ruby
if (word_to_guess.chars - letters_successfully_guessed).none?
  puts "Congratulations, you won!"
  break
end
```

Remember, `break` is used to stop a loop.

Now, for the losing conditions. We want to check if the user has run out of lives.

```ruby
if lives_remaining <= 0
  puts "You ran out of lives, suck it".
  break
end
```

Test it out! Do you lose when the lives hit 0?


[Iteration #5 Hints](#5)
----

You're now at the best stage! Making it pretty.

Copy the provided ascii art from the readme to the top of your program.

Start by replacing the code that tells the user how many lives they have left with this:

```
puts art[0]
```

It should print out a work of art every time you guess. However, we want it to change based on how many lifes the user has left. Think about how you might do that.

```
puts art[7 - lives_remaining]
```

