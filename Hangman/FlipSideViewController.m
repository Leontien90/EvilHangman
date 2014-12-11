//
//  FlipSideViewController.m
//  Hangman
//
//  Created by Leontien Boere on 10-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import "FlipSideViewController.h"
#import "GameController.h"

@interface FlipSideViewController ()

@end

@implementation FlipSideViewController

GameController *game;
NSUserDefaults *userDefaults;

/**
 * CONSTRUCTOR
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get default settings
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    // Init game controller
    game = [[GameController alloc] init];
    [game editSettings];
    
    // Set wordlength slider
    self.wordLengthLabel.text          = [NSString stringWithFormat:@"%0.0ld", (long)[userDefaults integerForKey:@"standardWordLength"]];
    self.wordLengthSlider.minimumValue = floor([game getMinWordLength]);
    self.wordLengthSlider.maximumValue = floor([game getMaxWordLength]);
    self.wordLengthSlider.value        = [userDefaults integerForKey:@"standardWordLength"];
    
    // Set amount of guesses slider
    self.amountOfGuessesLabel.text     = [NSString stringWithFormat:@"%0.0ld", (long)[userDefaults integerForKey:@"standardAmountOfGuesses"]];
    self.amountOfGuessesSlider.value   = [userDefaults integerForKey:@"standardAmountOfGuesses"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * STORE SLIDER VALUES
 */
-(IBAction)sliderValueChanged:(id)sender
{
    // Get default settings
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    // Store word length
    if (sender == self.wordLengthSlider)
    {
        int wordLengthLabel = floor(self.wordLengthSlider.value);
        self.wordLengthLabel.text = [NSString stringWithFormat:@"%d", wordLengthLabel];
        [userDefaults setInteger: self.wordLengthSlider.value forKey:@"standardWordLength"];
    }
    
    // Store amount of guesses
    if (sender == self.amountOfGuessesSlider)
    {
        int amountOfGuessesLabel = floor(self.amountOfGuessesSlider.value);
        self.amountOfGuessesLabel.text = [NSString stringWithFormat:@"%d", amountOfGuessesLabel];
        [userDefaults setInteger: self.amountOfGuessesSlider.value forKey:@"standardAmountOfGuesses"];
    }
}

@end

