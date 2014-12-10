//
//  GameController.h
//  Hangman
//
//  Created by Leontien Boere on 26-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameController : NSObject

- (void) loadWordList;
- (void) guessLetter:(NSString *)guessedLetter;
- (NSString *)getCurrentWord;
- (void) newGame;
- (NSMutableArray *)getGuessedLetterArray;
- (int)getCurrentWordCount;
- (int)getGuessesLeft;
- (NSString *)getCurrentWordString;
- (bool)winScenario;

@end

