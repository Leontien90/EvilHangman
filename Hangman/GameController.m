//
//  GameController.m
//  Hangman
//
//  Created by Leontien Boere on 26-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import "GameController.h"

@implementation GameController

-(void)loadWordList
{
    // Load plist into array
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    
    NSArray *thisArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    NSMutableArray *wordList = [[NSMutableArray alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int wordLength =  (int)[userDefaults integerForKey:@"standardWordLength"];
    for (NSString *word in thisArray)
    {
        if (word.length ==  wordLength)
        {
            [wordList addObject:word];
        }
    }
    NSLog(@"array count: %lu", (unsigned long)[wordList count]);
    
    NSMutableDictionary *words = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"short" ofType:@"plist"]];
    [words count];
    NSLog(@"%lu", (unsigned long)[words count]);
}

@end
