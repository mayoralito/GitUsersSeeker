//
//  MoviesDBManager.h
//  Picket
//
//  Created by amayoral on 4/10/14.
//  Copyright (c) 2014 adrianmayoral. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase, FMDatabaseQueue;

typedef void (^DBResponseSuccess) (NSDictionary* data);
typedef void (^DBResponseFail) (NSDictionary* data);
typedef void (^DBResponseError) (NSDictionary* data, NSString* errorMessage);


@interface MoviesDBManager : NSObject

/** database instances of FMDatabase */

@property (nonatomic, strong) FMDatabase *database;

/** queue instances of FMDatabaseQueue */

@property (nonatomic, strong) FMDatabaseQueue *queue;

+(instancetype)sharedInstance;

/** Open database and queue. */

+ (void)openDataBase;

/** Close database used by queue and normal instance. */

+ (void)closeDataBase;

/** Create core tables of application. */

+ (void)createCoreTables;

/** Get file path of DataBase. */

+ (NSString *)getFilePathDataBase;

/** Open database instance */
- (void)openDataBase;

/** Clase databse instance */
- (void)closeDataBase;



@end
