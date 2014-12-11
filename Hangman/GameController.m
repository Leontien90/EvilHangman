//
// GameController.m
// Hangman
//
// Created by Leontien Boere on 26-11-14.
// Copyright (c) 2014 Leontien Boere. All rights reserved.
//
// TODO comment gameController class

#import "GameController.h"

@implementation GameController
{
    NSUserDefaults *userDefaults;       // Default settings
    NSString *guessedLetter;            // Current guessed letter
    NSMutableArray *gameWord;           // Contains word to guess
    NSMutableArray *wordList;           // Contains words based on selected length
    NSMutableArray *guessedLetters;     // Contains input letters
    NSMutableDictionary *wordDict;      // Contains wordlists based on letter location
    int wordListLength;                 // Length of wordlist
    int guessesLeft;                    // Amount of guesses left
    int minWordLength;                  // Length of shortest word in wordlist
    int maxWordLength;                  // Length of longest word in wordlist
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) EDIT SETTINGS
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)editSettings
{
    // Get default settings
    userDefaults    = [NSUserDefaults standardUserDefaults];
    
    // Load wordlist
    [self loadWordList:FALSE];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (int) GET MIN WORD LENGTH
//////////////////////////////////////////////////////////////////////////////////////////////
- (int)getMinWordLength
{
    return minWordLength;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (int) GET MAX WORD LENGTH
//////////////////////////////////////////////////////////////////////////////////////////////
- (int)getMaxWordLength
{
    return maxWordLength;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) START A NEW GAME
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)newGame
{
    // Set default parameters
    userDefaults    = [NSUserDefaults standardUserDefaults];
    gameWord        = [[NSMutableArray alloc]init];
    guessedLetters  = [[NSMutableArray alloc]init];
    guessesLeft     = (int)[userDefaults integerForKey:@"standardAmountOfGuesses"];
    
    // Set game word
    int n = (int)[userDefaults integerForKey:@"standardWordLength"];
    for (int i = 0; i < n; i++)
    {
        [gameWord addObject:@"_"];
    }
    
    // Load wordlist
    [self loadWordList:TRUE];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) LOAD WORDLIST
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadWordList:(BOOL)filterOnLength
{
    // Load plist into wordlist
    NSString *path     = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSArray *wordsList = [[NSArray alloc] initWithContentsOfFile:path];
    wordList           = [[NSMutableArray alloc] init];
    int length         = (int)[userDefaults integerForKey:@"standardWordLength"];
    minWordLength      = 0;
    maxWordLength      = 0;
    for (NSString *word in wordsList)
    {
        if (!filterOnLength || (filterOnLength && word.length == length))
        {
            // Add word to wordlist
            [wordList addObject:word];
            
            // Check and update min/max word length
            int wordLength = (int)[word length];
            if (wordLength < minWordLength || minWordLength == 0)
            {
                minWordLength = wordLength;
            }
            if (wordLength > maxWordLength || maxWordLength == 0)
            {
                maxWordLength = wordLength;
            }
        }
    }
    
    // Update wordlist length
    wordListLength = (int)[wordList count];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) UPDATE WORDLIST (evil gameplay)
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)evilGameplay:(NSString *)userInput
{
    // Allocate memory
    wordDict = [[NSMutableDictionary alloc] init];
    
    // Set guessed letter
    guessedLetter = userInput;
    guessesLeft   = guessesLeft - 1;
    [guessedLetters addObject:guessedLetter];
    
    // Evil gameplay
    [self sortWordList];
    [self selectLongestWordList];
    [self updateGameWord];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) SORT WORDLIST DEPENDING ON LETTER LOCATION
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)sortWordList
{
    for (NSString *word in wordList)
    {
        // Allocate memory
        NSMutableArray *key       = [[NSMutableArray alloc]init];
        NSMutableArray *tempWords = [[NSMutableArray alloc]init];
        
        // Walk over lettter locations in word
        for (int location = 0; location < word.length; location++)
        {
            // Get letter for location
            NSString *temp = [NSString stringWithFormat:@"%c", [word characterAtIndex: location]];
            
            // Check if guessed letter is found
            if ([temp isEqualToString:guessedLetter])
            {
                // Append letter location to location key
                [key addObject:[NSString stringWithFormat:@"%d", location]];
            }
        }
        
        // Convert key array to string
        NSString *keyStr = [key componentsJoinedByString:@","];
        
        // Check if key already exists
        if ([[wordDict allKeys]containsObject:keyStr])
        {
            // Get current wordlist for key in dictionary
            tempWords = [wordDict valueForKeyPath:keyStr];
        }
        
        // Add word to wordlist
        [tempWords addObject:word];
        
        // Add word to location dictionary on key
        [wordDict setObject:tempWords forKey:keyStr];
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) SELECT LONGEST WORDLIST IN WORDDICT AND UPDATE WORDLIST
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)selectLongestWordList
{
    // Allocate memory and set parameters
    NSUInteger length    = 0;
    NSMutableArray *keys = [[NSMutableArray alloc]init];
    
    // Walk over keys in dictionary
    for (NSString* key in wordDict)
    {
        // Get wordlist for key
        NSMutableArray *listWords = [wordDict objectForKey:key];
        
        // Get length of wordlist
        NSUInteger listLength = listWords.count;
        
        // Do stuff depending on length of wordlist
        if (listLength >= length)
        {
            // Check if list is longer
            if (listLength > length)
            {
                // Clear list when longer
                [keys removeAllObjects];
                
                // Update max length
                length = listLength;
            }
            
            // Add wordDict key
            [keys addObject:key];
        }
    }
    
    // Check for multiple longest list
    if (keys.count > 1)
    {
        // Pick a random list
        int randomIndex = arc4random() % (keys.count - 1);
        wordList = wordDict[keys[randomIndex]];
    }
    else
    {
        // Select only list
        wordList = wordDict[keys[0]];
    }
    
    // Update wordlist length
    wordListLength = (int)[wordList count];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) UPDATE GAME WORD
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateGameWord
{
    for (NSString *word in wordList)
    {
        // Walk over lettter locations in word
        for (int location = 0; location < word.length; location++)
        {
            // Get letter for location
            char tempChar = [word characterAtIndex: location];
            
            // Convert letter to string
            NSString *temp = [NSString stringWithFormat:@"%c", tempChar];
            
            // Check if guessed letter is found
            if ([temp isEqualToString:guessedLetter])
            {
                // Append letter to word
                [gameWord replaceObjectAtIndex:location withObject:guessedLetter];
            }
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (bool) CHECK FOR LOSE SCENARIO
//////////////////////////////////////////////////////////////////////////////////////////////
- (bool)loseScenario
{
    if (guessesLeft < 1)
    {
        return true;
    }
    return false;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (bool) CHECK FOR WIN SCENARIO
//////////////////////////////////////////////////////////////////////////////////////////////
- (bool)winScenario
{
    for (id letter in gameWord)
    {
        if ([@"_" isEqualToString:letter])
        {
            return false;
        }
    }
    return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (int) GET CURRENT WORDLIST COUNT
//////////////////////////////////////////////////////////////////////////////////////////////
- (int)getCurrentWordCount
{
    return wordListLength;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (int) GET GUESSES LEFT
//////////////////////////////////////////////////////////////////////////////////////////////
- (int)getGuessesLeft
{
    return guessesLeft;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (string) GET GAME WORD
//////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray *)getGameWord
{
    return gameWord;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (string) GET GUESSED LETTERS
//////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray *)getGuessedLetters
{
    return guessedLetters;
}

@end
