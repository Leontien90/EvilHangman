//
//  ViewController.h
//  Hangman
//
//  Created by Leontien Boere on 10-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *turnsLeftLabel;
@property (weak, nonatomic) IBOutlet UITextField *letterEntryField;
@property (weak, nonatomic) IBOutlet UILabel *wordToGuessLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessedLetters;
@property (weak, nonatomic) IBOutlet UILabel *amountOfWords;


- (IBAction)changeTextClick:(id)sender;

@end

