//
//  SecondViewController.h
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetPostViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *wordCountView;
- (IBAction)postTweet:(id)sender;
- (IBAction)cancelEditing:(id)sender;

@end
