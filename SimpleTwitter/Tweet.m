//
//  Tweet.m
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import "Tweet.h"
#import "TDOAuth.h"
#import <RestKit/RestKit.h>
#import "OAuth.h"


static NSString *kTWITTER_HOME_TIMELINE = @"/1.1/statuses/home_timeline.json";
static NSString *kTWITTER_TWEET = @"/1.1/statuses/update.json";
static NSString *kTWITTER_API = @"api.twitter.com";

@implementation Tweet

+ (void) tweetsWithOAuth:(OAuth *) oauth success:(void (^)(NSArray *))tweets
{
    NSURLRequest *request = [TDOAuth URLRequestForPath:kTWITTER_HOME_TIMELINE
                                     GETParameters:nil
                                            scheme:@"http"
                                              host:kTWITTER_API
                                       consumerKey:oauth.consumerKey
                                    consumerSecret:oauth.consumerSecret
                                       accessToken:oauth.accessToken
                                       tokenSecret:oauth.tokenSecret];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Tweet class]];
    [mapping addAttributeMappingsFromDictionary:@{
         @"user.screen_name":         @"username",
         @"user.profile_image_url":   @"imageUrl",
         @"text":                     @"content",
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                                    responseDescriptorWithMapping:mapping
                                                    pathPattern:nil
                                                    keyPath:nil
                                                    statusCodes:nil];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc]
                                                initWithRequest:request
                                                responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        NSArray *array = [result array];
        NSLog(@"The public timeline Tweets: %@", array);
        
        tweets(array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
    
    [operation start];
}

+ (void) postTweet:(NSString *)tweet withOAuth: (OAuth *)oauth result:(void (^)(BOOL, NSString *))delegate
{
    NSURLRequest *request = [TDOAuth URLRequestForPath:kTWITTER_TWEET
                                        POSTParameters:@{@"status":tweet}
                                                  host:kTWITTER_API
                                           consumerKey:oauth.consumerKey
                                        consumerSecret:oauth.consumerSecret
                                           accessToken:oauth.accessToken
                                           tokenSecret:oauth.tokenSecret];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
            NSLog(@"%@", json);
            delegate(YES, nil);
        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id json) {
            NSLog(@"%@", error);
            NSArray *errors = [json objectForKey:@"errors"];
            NSString *msg = [errors[0] objectForKey:@"message"];
            NSLog(@"%@", msg);
            
            delegate(NO, msg);
        }];
    
    [operation start];
}
@end
