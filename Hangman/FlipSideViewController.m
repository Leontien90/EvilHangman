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
        int wordLengthLabel = floor(self.wordLengthSlider.value);
        self.wordLengthLabel.text = [NSString stringWithFormat:@"%d", wordLengthLabel];
        [userDefaults setInteger: self.wordLengthSlider.value forKey:@"standardWordLength"];
        NSLog(@"%@", self.wordLengthLabel.text);
    }
    if (sender == self.amountOfGuessesSlider)
    {
        int amountOfGuessesLabel = floor(self.amountOfGuessesSlider.value);
        self.amountOfGuessesLabel.text = [NSString stringWithFormat:@"%d", amountOfGuessesLabel];
        [userDefaults setInteger: self.amountOfGuessesSlider.value forKey:@"standardAmountOfGuesses"];
        NSLog(@"%@", self.amountOfGuessesLabel.text);
    }
}

@end

