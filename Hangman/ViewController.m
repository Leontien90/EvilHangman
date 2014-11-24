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
    [self setDefaultValues];
    
    // hide textfield by default
    self.letterEntryField.hidden = YES;
    
    //display keyboard
    [self.letterEntryField becomeFirstResponder];
}

-(void)loadWordList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"short" ofType:@"plist"];
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
    NSLog(@"%@", self.letterEntryField.text);
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
