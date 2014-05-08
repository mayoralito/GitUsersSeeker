//
//  UsersDBManager.m
//  GitUsersSeeker
//
//  Created by amayoral on 5/8/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import "UsersDBManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation UsersDBManager
static id shared = NULL;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

#pragma mark -
#pragma mark - Pubic Methods
+ (void)initConfig{
    [[UsersDBManager sharedInstance] initConfig];
}
+ (void)storeGitHubUsers:(NSArray *)data{
    [[UsersDBManager sharedInstance] storeGitHubUsers:data];
}

#pragma mark -
#pragma mark - Private Methods
- (void)initConfig
{
    
}

- (void)storeGitHubUsers:(NSArray *)data
{
    [self openDataBase];
    //[self.queue inDatabase:^(FMDatabase *db) {
        for(int i = 0; i < [data count]; i ++)
        {
            NSDictionary *gitInfo = [data objectAtIndex:i];
            
            [self.database executeUpdate:@"INSERT INTO github_users (id, login, avatar_url, type) VALUES (?, ?, ?, ?)",
             (int)[gitInfo valueForKey:@"id"],
             [gitInfo valueForKey:@"login"],
             [gitInfo valueForKey:@"avatar_url"],
             [gitInfo valueForKey:@"type"], nil];
            
        }
        
    //}];
}


@end
