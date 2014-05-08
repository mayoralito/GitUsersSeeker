//
//  NSString+JSON.h
//  Picket
//
//  Created by amayoral on 4/9/14.
//  Copyright (c) 2014 adrianmayoral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)
+ (NSString *)dictionaryAsString : (NSDictionary *)dict;
+ (NSString *)getDateStringWithFormat : (NSDate *)date formatString:(NSString *)formatString interval: (NSInteger) interval;
@end
