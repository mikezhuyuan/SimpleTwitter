//
//  Oauth.m
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import "OAuth.h"
static OAuth *_oauth_from_plist;
@implementation OAuth

+ (OAuth *) loadFromPlist {
    if(!_oauth_from_plist) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"oauth" ofType:@"plist"]; 
        NSDictionary *map = [[NSDictionary alloc] initWithContentsOfFile:path];
        OAuth *oauth = [[OAuth alloc]init];
        
        oauth.consumerKey = [map objectForKey:@"consumerKey"];
        oauth.consumerSecret = [map objectForKey:@"consumerSecret"];
        oauth.accessToken = [map objectForKey:@"accessToken"];
        oauth.tokenSecret = [map objectForKey:@"tokenSecret"];
        
        _oauth_from_plist = oauth;
    }
    
    return _oauth_from_plist;
}
@end
