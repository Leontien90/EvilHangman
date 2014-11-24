//
//  ViewController.m
//  Hangman
//
//  Created by Leontien Boere on 10-11-14.
//  Copyright (c) 2014 Leontien Boere. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadWordList];
    //[self setDefaultValues];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%ld", [userDefaults integerForKey:@"standardWordLength"]);
    if ([userDefaults integerForKey:@"standardWordLength"] == 0)
    {
        [self setDefaultValues];
    }
    
    self.turnsLeftLabel.text = [NSString stringWithFormat:@"%0.0ld", (long)[userDefaults integerForKey:@"standardAmountOfGuesses"]];
    
    // hide textfield by default
    self.letterEntryField.hidden = YES;

    //display keyboard
    [self.letterEntryField becomeFirstResponder];
}

-(void)loadWordList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSLog(@"file found");
    }
    else
    {
        NSLog(@"file not found");
    }
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
