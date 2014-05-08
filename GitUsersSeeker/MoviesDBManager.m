//
//  MoviesDBManager.m
//  Picket
//
//  Created by amayoral on 4/10/14.
//  Copyright (c) 2014 adrianmayoral. All rights reserved.
//

#import "MoviesDBManager.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation MoviesDBManager{
    FMDatabase *database;
    FMDatabaseQueue *queue;
}

@synthesize database, queue;

static id shared = NULL;

+(instancetype)sharedInstance {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

#pragma mark -
#pragma mark - Pubic Methods
+ (NSString *)getFilePathDataBase{
    return [[MoviesDBManager sharedInstance] getFilePathDataBase];
}
+ (void)openDataBase{
    [[MoviesDBManager sharedInstance] openDataBase];
}
+ (void)closeDataBase{
    [[MoviesDBManager sharedInstance] closeDataBase];
}

#pragma mark -
#pragma mark - Private Methods
- (NSString *)getFilePathDataBase
{
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [cachesDirectory   stringByAppendingPathComponent:@"GitHubDB.sql"];
    
    NSLog(@"dbPath: %@", dbPath);
    
    return dbPath;
}

- (void)openDataBase
{
    if(nil == database){
        database = [FMDatabase databaseWithPath:[self getFilePathDataBase]];
    }
    if(nil == queue){
        queue = [FMDatabaseQueue databaseQueueWithPath:[self getFilePathDataBase]];
    }
    
    [database open];
}

- (void)closeDataBase
{
    [database close];
    [queue close];
}

- (void)dealloc{
    database = nil;
    queue = nil;
}

@end
