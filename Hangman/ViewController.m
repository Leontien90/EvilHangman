//
//  ViewController.m
//  Hangman
//
//  Created by Leontien Boere on 10-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import "ViewController.h"
#import "GameController.h"

@interface ViewController ()

@end

@implementation ViewController

GameController *game;
NSUserDefaults *userDefaults;

//////////////////////////////////////////////////////////////////////////////////////////////
// CONSTRUCTOR
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    // Init user defaults
    userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults integerForKey:@"standardWordLength"] == 0)
    {
        [self setDefaultValues];
    }
    
    // Hide textfield by default
    self.letterEntryField.hidden = YES;
    
    // Handle keyboard
    self.letterEntryField.autocorrectionType = UITextAutocorrectionTypeNo;  // Disable autocorrect
    [self.letterEntryField becomeFirstResponder];                           // Display keyboard
    
    // Start new game
    [self startNewGame];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// HANDLE MEMORY WARNING
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

//////////////////////////////////////////////////////////////////////////////////////////////
// SET STANDARD USER DEFAULTS
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDefaultValues
{
    [userDefaults setInteger: 4 forKey:@"standardWordLength"];
    [userDefaults setInteger: 8 forKey:@"standardAmountOfGuesses"];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// ON NEW GAME BUTTON
//////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)onButtonNewGame:(id)sender
{
    // Start new game
    [self startNewGame];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// START A NEW GAME
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)startNewGame
{
    // Init game controller
    game = [[GameController alloc] init];
    
    // Start new game
    [game newGame];
    
    // Set labels
    self.turnsLeftLabel.text    = [NSString stringWithFormat:@"%0.0ld", (long)[userDefaults integerForKey:@"standardAmountOfGuesses"]];
    self.guessedLetters.text    = @"none";
    self.amountOfWords.text     = [NSString stringWithFormat:@"%d", [game getCurrentWordCount]];
    self.wordToGuessLabel.text  = [game getCurrentWordString];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// ON TEXT INPUT
// TODO: - win scenario
//       - lose scenario
//       - continue scenario
//       - info label
//////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)changeTextClick:(id)sender
{
    // Get letter input (uppercase)
    NSString *currentGuessedLetter = [self.letterEntryField.text uppercaseString];

    // Validate input against character set
    if ([currentGuessedLetter rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound)
    {
        // Validate input does not already exist
        if ([[[game getGuessedLetterArray] componentsJoinedByString:@""] rangeOfString:currentGuessedLetter].location == NSNotFound)
        {
            // Run algorithme
            [game guessLetter:currentGuessedLetter];
            
            // Set labels
            if ([game getGuessesLeft] > 0)
            {
                self.turnsLeftLabel.text = [NSString stringWithFormat:@"%d", [game getGuessesLeft]];
            }
            else
            {
                self.turnsLeftLabel.text = @"You lose :(";
            }
            self.guessedLetters.text     = [[game getGuessedLetterArray] componentsJoinedByString:@" "];
            self.amountOfWords.text      = [NSString stringWithFormat:@"%d", [game getCurrentWordCount]];
            self.wordToGuessLabel.text   = [game getCurrentWordString];
        }
    }
    
    // Reset letterEntryField
    self.letterEntryField.text = @"";
}

@end
