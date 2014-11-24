//
//  FlipSideViewController.h
//  Hangman
//
//  Created by Leontien Boere on 10-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface FlipSideViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthLabel;

@property (weak, nonatomic) IBOutlet UISlider *amountOfGuessesSlider;
@property (weak, nonatomic) IBOutlet UILabel *amountOfGuessesLabel;

-(IBAction)sliderValueChanged:(id)sender;

@end
