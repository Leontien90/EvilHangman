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


- (void)viewDidLoad;
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Init user defaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults integerForKey:@"standardWordLength"] == 0)
    {
        [self setDefaultValues];
    }
    
    // Init default guessesLeft label text
    self.turnsLeftLabel.text = [NSString stringWithFormat:@"%0.0ld", (long)[userDefaults integerForKey:@"standardAmountOfGuesses"]];
    
    // Hide textfield by default
    self.letterEntryField.hidden = YES;

    // Display keyboard
    self.letterEntryField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.letterEntryField becomeFirstResponder];
    
    // Init game controller
    game = [[GameController alloc] init];
    
    // Start new game
    [game newGame];
    
    // Load wordlist
    [game loadWordList];
    
    // Init current word count
    [game getCurrentWordCount];
    
    // Init word to guess (underscores) label text
    self.wordToGuessLabel.text = [game getCurrentWord];
    
    // Init amount of words label text
    NSString *amountOfWords = [NSString stringWithFormat:@"%d", [game getCurrentWordCount]];
    self.amountOfWords.text = amountOfWords;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)changeTextClick:(id)sender
{
    // Update guessedLetter label text
    NSString *currentGuessedLetter = self.letterEntryField.text;
    self.letterEntryField.text = @"";
    self.wordToGuessLabel.text = currentGuessedLetter;

    // Update guessedLetters label text
    [game guessLetter:currentGuessedLetter];
    NSString *guessedLetters = [[game getGuessedLetterArray] componentsJoinedByString:@" "];
    self.guessedLetters.text = guessedLetters;
    
    // Update guessesLeft label text
    if ([game getGuessesLeft] > 0)
    {
        self.turnsLeftLabel.text = [NSString stringWithFormat:@"%d", [game getGuessesLeft]];
    }
    else
    {
       self.turnsLeftLabel.text  = [NSString stringWithFormat:@"You lose :("];
    }
    
    // Update amount of words label text
    NSString *amountOfWords = [NSString stringWithFormat:@"%d", [game getCurrentWordCount]];
    self.amountOfWords.text = amountOfWords;
}

- (void)setDefaultValues
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger: 4 forKey:@"standardWordLength"];
    [userDefaults setInteger: 8 forKey:@"standardAmountOfGuesses"];
}

@end
