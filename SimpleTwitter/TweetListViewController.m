//
//  FirstViewController.m
//  SimpleTwitter
//
//  Created by mike on 7/06/13.
//  Copyright (c) 2013 mikezhuyuan. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetViewCell.h"
#import "Tweet.h"
#import "OAuth.h"

@interface TweetListViewController ()
@property (nonatomic, strong) NSArray *tweets;
@end

@implementation TweetListViewController
{
    BOOL _isLoading;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadTweets];
}

- (void) loadTweets
{
    if(!_isLoading) {
        OAuth *oauth = [OAuth loadFromPlist];
        
        [self.indicatorView startAnimating];
        _isLoading = YES;
        NSLog(@"Start loading tweets...");
        [Tweet tweetsWithOAuth:oauth success:^(NSArray *tweets) {
            self.tweets = tweets;
            [self.tableView reloadData];
            [self.indicatorView stopAnimating];
            _isLoading = NO;
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.tweets = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Tweet *tweet = self.tweets[indexPath.row];
    
    [cell setTweet:tweet];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TweetViewCell heightForCellWithTweet:[[self tweets] objectAtIndex:indexPath.row]];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger offset = scrollView.contentOffset.y;
    
    if(offset < -50) {
        [self loadTweets];
    }
}
@end
