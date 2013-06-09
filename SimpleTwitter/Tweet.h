//
//  Tweet.h
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OAuth;

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *content;

+ (void) tweetsWithOAuth:(OAuth *) oauth success:(void (^)(NSArray *))tweets;
+ (void) postTweet:(NSString *)tweet withOAuth: (OAuth *)oauth result:(void (^)(BOOL result, NSString *msg))delegate;

@end
