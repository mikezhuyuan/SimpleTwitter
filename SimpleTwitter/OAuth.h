//
//  Oauth.h
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth : NSObject

@property (nonatomic, strong) NSString *consumerKey;
@property (nonatomic, strong) NSString *consumerSecret;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *tokenSecret;


+(OAuth *) loadFromPlist;
@end
