EvilHangman
===========

Introduction
------------

This design document describes the implementation for the evil hangman app. Evil hangman is almost like the regular hangman with the difference that it keeps changing the word it has in ‘mind’. 

Mockups
-------

![Alt text](https://github.com/Leontien90/EvilHangman/blob/master/docs/hangman_mockup.png "Hangman Mockups")

The images above show the view of the application. All the action takes place at the home screen. 

The home screen displays several functions:

-	settings button which brings the user to the settings screen (as discussed later)
-	a counter that displays how many turns the user has left
-	place holders for yet un guessed letters that make clear the words length 
-	a counter that displays how many words are possible
-	a keyboard that displays the letters the user hasn’t picked yet

as mentioned before the settings button brings the user to the settings screen, this screen displays two functions:

-	the option to choose the length of the word 
-	the option to choose the amount of guesses the user gets. 
-	a button that brings the user back to the home screen

Implementation
--------------

There will be two controllers
-	MainViewController (home screen)
-	FlipSideViewController (settings screen)

Global params
- Param: letterCount(int)
- Param: guessCount(int)
- Param: guessCountLeft(int)
- Param: wordCountLeft(int)
- Param: dictionary(hashtable)
- Param: guessList(array)

Class: Settings
- Method: setLetterCount(letterCount)
- Method: getLetterCount()
	- Return int
- Method: setGuessCount(letterCount)
- Method: getGuessCount()
	- Return int

Class: Game
- Method: loadDictionary
- Method: setLetter(letter)
- Method: updateGuessCountLeft
- Method: resetGuessCountLeft
- Method: setWordCountleft(amount)
- Method: updateDictionary
- Method: updateGuessList(letter, position)
- Method: removeLetter(letter)
- Method: newGame

Class: Navigation
- Method: showMainView
- Method: showSettingsView

evil algorithm
--------------

the main structure of this game is the algorithm that makes this game so evil. Everytime the user guesses a letter
the word that the computer has in mind changes. For example the settings are set on 3 letter words, and the user 
guesses the letter 'A' the computer makes 4 classes called equivalence classes.

- class for the words that do not contain the letter 'A'
- class for the words that contain the letter 'A' in 1st position ( A _ _ )
- class for the words that contain the letter 'A' in 2nd position ( _ A _ )
- class for the words that contain the letter 'A' in 3rd position ( _ _ A )

the list that contains the most words will be used to continue the game. If two of the lists are equally in length 
via a pseudorandomly choice there will be determined with what list to continue. 



