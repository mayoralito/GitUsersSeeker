//
//  UsersDBManager.h
//  GitUsersSeeker
//
//  Created by amayoral on 5/8/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import "MoviesDBManager.h"

@interface UsersDBManager : MoviesDBManager
+ (instancetype)sharedInstance;
+ (void)initConfig;
+ (void)storeGitHubUsers:(NSArray *)data;
@end
