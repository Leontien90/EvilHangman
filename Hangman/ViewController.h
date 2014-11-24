//
//  ViewController.h
//  Hangman
//
//  Created by Leontien Boere on 10-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *turnsLeftLabel;
@property (weak, nonatomic) IBOutlet UITextField *letterEntryField;
@property (weak, nonatomic) IBOutlet UILabel *wordToGuessLabel;


@end

