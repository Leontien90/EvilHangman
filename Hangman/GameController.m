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
    NSMutableArray *guessedLetterArray;
    NSMutableArray *wordList;
    NSString *currentWord;
    int wordListLength;
    int guessesLeft;
}

- (void)newGame
{
    guessedLetterArray = [[NSMutableArray alloc]init];
    currentWord = @"- - - -";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    guessesLeft = (int)[userDefaults integerForKey:@"standardAmountOfGuesses"];
}

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

- (void)guessLetter:(NSString *)guessedLetter
{
    // update guessesLeft label
    [guessedLetterArray addObject:guessedLetter];
    guessesLeft = guessesLeft - 1;
    if (guessesLeft == 0)
    {
        //show loser message to loser player and start new game
    }
    
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
}


- (NSMutableArray *)getGuessedLetterArray
{
    return guessedLetterArray;
}

- (NSString *)getCurrentWord
{
    return currentWord;
}

@end
