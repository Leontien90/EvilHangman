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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sliderValueChanged:(id)sender
{
    if (sender == self.wordLengthSlider)
    {
        self.wordLengthLabel.text = [NSString stringWithFormat:@"%0.0f", self.wordLengthSlider.value];
    }
    if (sender == self.amountOfGuessesSlider)
    {
        self.amountOfGuessesLabel.text = [NSString stringWithFormat:@"%0.0f", self.amountOfGuessesSlider.value];
    }
    
}

@end

