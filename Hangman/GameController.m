//
//  GameController.m
//  Hangman
//
//  Created by Leontien Boere on 26-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import "GameController.h"

@implementation GameController
{
    NSMutableArray *gameWord;           // Contains word to guess
    NSMutableArray *wordList;           // Contains words based on selected length
    NSMutableArray *guessedLetters;     // Contains input letters
    
    NSString *currentWord;
    NSString *currentWordString;
    
    int wordListLength;
    int guessesLeft;
    int currentWordLength;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) START A NEW GAME
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)newGame
{
    guessedLetters = [[NSMutableArray alloc]init];
    gameWord = [[NSMutableArray alloc]init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    guessesLeft = (int)[userDefaults integerForKey:@"standardAmountOfGuesses"];
    
    currentWordLength = (int) [userDefaults integerForKey:@"standardWordLength"];
    for (int i = 0; i < currentWordLength; i++)
    {
        [gameWord addObject:@"_"];
    }
    
    // Load wordlist
    [self loadWordList];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) UPDATE WORDLIST (evil gameplay)
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) UPDATE GAME WORD
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) UPDATE GUESSED LETTERS
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (void) UPDATE GUESSES LEFT
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (bool) CHECK FOR LOSE SCENARIO
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (bool) CHECK FOR WIN SCENARIO
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (int) GET WORDLIST COUNT
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (int) GET GUESSES LEFT
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (string) GET GAME WORD
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// (string) GET GUESSED LETTERS
//////////////////////////////////////////////////////////////////////////////////////////////

- (void)loadWordList
{
    // Load plist into array
    NSString *path = [[NSBundle mainBundle] pathForResource:@"short" ofType:@"plist"];
    
    NSArray *thisArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    // create new array based on standardWordLength
    wordList = [[NSMutableArray alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int wordLength =  (int)[userDefaults integerForKey:@"standardWordLength"];
    for (NSString *word in thisArray)
    {
        if (word.length == wordLength)
        {
            [wordList addObject:word];
        }
    }
    wordListLength = (int)[wordList count];
}

- (int)getCurrentWordCount
{
    return wordListLength;
}

- (int)getGuessesLeft
{
    return guessesLeft;
}

- (NSString *)getCurrentWordString
{
    // convert currenWordArray to string
    currentWordString = [gameWord componentsJoinedByString:@" "];
    
    return currentWordString;
}

- (NSMutableArray *)getGuessedLetterArray
{
    return guessedLetters;
}

- (NSString *)getCurrentWord
{
    return currentWord;
}

- (void)guessLetter:(NSString *)guessedLetter
{
    //////////////////////////////////////////////////////////////////////////////////////////////
    // COMPUTE WORD LISTS
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    // Init location dictionary
    NSMutableDictionary *wordDict = [[NSMutableDictionary alloc] init];
    
    for (NSString *word in wordList)
    {
        // Init location key
        NSMutableArray *key = [[NSMutableArray alloc]init];
        
        // Init temp words
        NSMutableArray *tempWords = [[NSMutableArray alloc]init];
        
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
    
    // Log location dictionary
    NSLog(@"%@", wordDict);
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    // COMPUTE DICTIONARY BY LIST LENGTH
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    // Init list length
    NSUInteger length = 0;
    
    // Init list keys
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
    
    // Log length dictionary
    NSLog(@"%lu", length);
    NSLog(@"%@", keys);
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    // SELECT LONGEST LIST
    //////////////////////////////////////////////////////////////////////////////////////////////
    
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
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    // FILL IN GUESSED LETTER (WHEN FOUND)
    //////////////////////////////////////////////////////////////////////////////////////////////

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
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    // UPDATE VIEW DATA
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    // Update guessesLeft label
    guessesLeft = guessesLeft - 1;
    if (guessesLeft < 0)
    {
        //start new game
        [self newGame];
    }
    
    // Update guessed letters array
    [guessedLetters addObject:guessedLetter];
    
    // Update wordList length label
    wordListLength = (int)[wordList count];
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    // WIN SCENARIO
    //////////////////////////////////////////////////////////////////////////////////////////////

    NSLog(@"%@", gameWord);
    for (id letter in gameWord)
    {
        if ([letter isEqualToString:@"_"])
        {
            // show lose message to loser player
            NSLog(@"you lose");
        }

    }

}




@end
