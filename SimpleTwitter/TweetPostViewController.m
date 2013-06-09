//
//  SecondViewController.m
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import "TweetPostViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Tweet.h"
#import "OAuth.h"

@interface TweetPostViewController ()

@end

@implementation TweetPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self.textView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.textView layer] setBorderWidth:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postTweet:(id)sender {
    OAuth *oauth = [OAuth loadFromPlist];
    
    NSString *tweet = self.textView.text;
    [Tweet postTweet:tweet withOAuth:oauth result:^(BOOL result, NSString *msg) {
        if(result) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Congulatuations"
                                                              message:@"Your tweet has been posted."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
            
            self.textView.text = nil;
            self.wordCountView.text = @"140";
        } else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                              message:msg
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }];
}

- (IBAction)cancelEditing:(id)sender {
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger wordLeft = 140 - self.textView.text.length;
    self.wordCountView.text = [@(wordLeft) stringValue];
}
@end
