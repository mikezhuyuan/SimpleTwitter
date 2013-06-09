//
//  TweetViewCell.h
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tweet;

@interface TweetViewCell : UITableViewCell

- (void) setTweet:(Tweet *) tweet;
+ (CGFloat)heightForCellWithTweet:(Tweet *)tweet;

@end
