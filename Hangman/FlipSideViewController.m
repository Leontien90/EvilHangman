//
//  FlipSideViewController.m
//  Hangman
//
//  Created by Leontien Boere on 10-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import "FlipSideViewController.h"

@interface FlipSideViewController ()

@end

@implementation FlipSideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.wordLengthSlider.value = [userDefaults integerForKey:@"standardWordLength"];
    self.wordLengthLabel.text = [NSString stringWithFormat:@"%0.0ld", (long)[userDefaults integerForKey:@"standardWordLength"]];
    
    self.amountOfGuessesSlider.value = [userDefaults integerForKey:@"standardAmountOfGuesses"];
    self.amountOfGuessesLabel.text = [NSString stringWithFormat:@"%0.0ld", (long)[userDefaults integerForKey:@"standardAmountOfGuesses"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Change slide value and update standardUserDefaults
-(IBAction)sliderValueChanged:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (sender == self.wordLengthSlider)
    {
        self.wordLengthLabel.text = [NSString stringWithFormat:@"%0.0f", self.wordLengthSlider.value];
        [userDefaults setInteger: self.wordLengthSlider.value forKey:@"standardWordLength"];
    }
    if (sender == self.amountOfGuessesSlider)
    {
        self.amountOfGuessesLabel.text = [NSString stringWithFormat:@"%0.0f", self.amountOfGuessesSlider.value];
        [userDefaults setInteger:self.amountOfGuessesSlider.value forKey:@"standardAmountOfGuesses"];
    }
}

@end

