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
    NSMutableDictionary *wordDict = [[NSMutableDictionary alloc] init];
    
    wordListWithLetter = [[NSMutableArray alloc] init];
    wordListWithoutLetter = [[NSMutableArray alloc] init];
    for (NSString *word in wordList)
    {
        NSMutableArray *key = [[NSMutableArray alloc]init];
        for (int location = 0; location < word.length; location++)
        {
            char tempChar = [word characterAtIndex: location];
            NSString *temp = [NSString stringWithFormat:@"%c", tempChar];
            if ([temp isEqualToString:guessedLetter])
            {
                // create keys and add values and than do stuff! godammit
                [key addObject:[NSString stringWithFormat:@"%d", location]];
                if ([key isEqualToArray:key])
                {
                    // add value to existing key value pair
                }
            }
        }
        [wordDict setObject:word forKey:key];
        NSLog(@"%@", wordDict);
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
