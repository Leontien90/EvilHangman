//
//  GameController.h
//  Hangman
//
//  Created by Leontien Boere on 26-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//
// - declares which functions can be used by view controller

#import <Foundation/Foundation.h>

@interface GameController : NSObject

- (void)editSettings;
- (void)newGame;
- (void)evilGameplay:(NSString *)userInput;
- (NSMutableArray *)getGameWord;
- (NSMutableArray *)getGuessedLetters;
- (int)getCurrentWordCount;
- (int)getGuessesLeft;
- (int)getMinWordLength;
- (int)getMaxWordLength;
- (bool)winScenario;
- (bool)loseScenario;

@end

