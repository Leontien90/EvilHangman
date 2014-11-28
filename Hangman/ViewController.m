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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // set default values
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults integerForKey:@"standardWordLength"] == 0)
    {
        [self setDefaultValues];
    }
    
    self.turnsLeftLabel.text = [NSString stringWithFormat:@"%0.0ld", (long)[userDefaults integerForKey:@"standardAmountOfGuesses"]];
    
    // hide textfield by default
    self.letterEntryField.hidden = YES;

    //display keyboard
    [self.letterEntryField becomeFirstResponder];
    
    GameController *game = [[GameController alloc] init];
    [game loadWordList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)changeTextClick:(id)sender
{
    NSString *customText = self.letterEntryField.text;
    self.wordToGuessLabel.text = customText;
}

- (void)setDefaultValues
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:4 forKey:@"standardWordLength"];
    [userDefaults setInteger:8 forKey:@"standardAmountOfGuesses"];
}

@end
