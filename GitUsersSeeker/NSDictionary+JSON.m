//
//  NSDictionary+JSON.m
//  Picket
//
//  Created by amayoral on 4/9/14.
//  Copyright (c) 2014 adrianmayoral. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)
+ (NSDictionary *)stringAsDictionary : (NSString *)stringJson
{
    NSError *error;
    NSData *resultData = [stringJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&error];
    return result;
}
@end