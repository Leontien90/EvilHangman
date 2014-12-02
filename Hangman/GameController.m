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
    NSMutableArray *wordListWithLetter;
    NSMutableArray *wordListWithoutLetter;
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
    
    // iterate over words in wordList
    wordListWithLetter = [[NSMutableArray alloc] init];
    wordListWithoutLetter = [[NSMutableArray alloc] init];
    for (NSString *word in wordList)
    {
        NSRange letter = [word rangeOfString:guessedLetter];
        if (letter.length == 1)
        {
            [wordListWithLetter addObject:word];
        }
        else
        {
            [wordListWithoutLetter addObject:word];
        }
    }
    
    // check which array is the longest and than do stuff! godammit.
    if (wordListWithoutLetter.count < wordListWithLetter.count)
    {
        NSLog(@"with letter: %lu", (unsigned long)wordListWithLetter.count);
        // for letter in words in array check letter location
        for (letter in wordListWithLetter)
        {
            // find the goddamn location of the letter in the word you, you person! 
        }
    }
    else
    {
        NSLog(@"without letter: %lu", (unsigned long)wordListWithoutLetter.count);
        // go back to previous if statement (the one where it checks for existing letters.
    }
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
