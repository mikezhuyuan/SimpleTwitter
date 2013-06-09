//
//  TweetViewCell.m
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import "TweetViewCell.h"
#import "Tweet.h"
#import <AFNetworking/AFNetworking.h>

@implementation TweetViewCell
{
    Tweet *_tweet;
}

- (void) setTweet:(Tweet *) tweet
{
    _tweet = tweet;
    
    self.textLabel.text = _tweet.username;
    self.detailTextLabel.text = _tweet.content;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:_tweet.imageUrl]
                    placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
    self.textLabel.frame = CGRectMake(70.0f, 10.0f, 240.0f, 20.0f);
    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    CGFloat height = [[self class] heightForCellWithTweet:_tweet] - 45.0f;
    detailTextLabelFrame.size.height = height;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

+ (CGFloat)heightForCellWithTweet:(Tweet *)tweet {
    CGSize sizeToFit = [tweet.content sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}
@end
