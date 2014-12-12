//
//  ViewController.m
//  Hangman
//
//  Created by Leontien Boere on 10-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//
// - updates labels
// - handles user input

#import "ViewController.h"
#import "GameController.h"

@interface ViewController ()

@end

@implementation ViewController

GameController *game;
NSUserDefaults *userDefaults;

/**
 * CONSTRUCTOR
 **/
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

/**
 * HANDLING MEMORY WARNINGS
 **/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

/**
 * SET STANDARD USER DEFAULTS
 **/
- (void)setDefaultValues
{
    [userDefaults setInteger: 4 forKey:@"standardWordLength"];
    [userDefaults setInteger: 8 forKey:@"standardAmountOfGuesses"];
}

/**
 * ON NEW GAME BUTTON
 **/
- (IBAction)onButtonNewGame:(id)sender
{
    // Start new game
    [self startNewGame];
}

/**
 * START A NEW GAME
 **/
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
    self.wordToGuessLabel.text  = [[game getGameWord] componentsJoinedByString:@" "];
}

/**
 * ON TEXT INPUT
 * - validate user input and check game status before passing arguments to gameController
 **/
- (IBAction)changeTextClick:(id)sender
{
    // Get letter input (uppercase)
    NSString *userInput = [self.letterEntryField.text uppercaseString];

    // Validate input against character set
    if ([userInput rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound)
    {
        // Validate input does not already exist
        if ([[[game getGuessedLetters] componentsJoinedByString:@""] rangeOfString:userInput].location == NSNotFound)
        {
            // Run algorithme
            [game evilGameplay:userInput];
            
            // Set labels
            self.turnsLeftLabel.text    = [NSString stringWithFormat:@"%d", [game getGuessesLeft]];
            self.guessedLetters.text    = [[game getGuessedLetters] componentsJoinedByString:@" "];
            self.amountOfWords.text     = [NSString stringWithFormat:@"%d", [game getCurrentWordCount]];
            self.wordToGuessLabel.text  = [[game getGameWord] componentsJoinedByString:@" "];
            
            // Check current game state
            if([game winScenario])
            {
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello winner!"
                                                                  message:@"guess what, you won!!"
                                                                 delegate:self
                                                        cancelButtonTitle:@"New Game"
                                                        otherButtonTitles:nil];
                [message show];
            }
            else if ([game loseScenario])
            {
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello loser!"
                                                                  message:@"guess what, you lost."
                                                                 delegate:self
                                                        cancelButtonTitle:@"New Game"
                                                        otherButtonTitles:nil];
                [message show];
            }
        }
    }
    
    // Reset letterEntryField
    self.letterEntryField.text = @"";
}

/**
 * HANDLING ALERT VIEW
 **/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"New Game"])
    {
        [self startNewGame];
    }
}

@end
