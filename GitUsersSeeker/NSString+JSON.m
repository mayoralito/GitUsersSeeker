//
//  NSString+JSON.m
//  Picket
//
//  Created by amayoral on 4/9/14.
//  Copyright (c) 2014 adrianmayoral. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

+ (NSString *)dictionaryAsString : (NSDictionary *)dict
{
    NSData *resultData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *result = [[NSString alloc] initWithData:resultData encoding:NSASCIIStringEncoding];
    return result;
}

+ (NSString *)getDateStringWithFormat : (NSDate *)date formatString:(NSString *)formatString interval: (NSInteger) interval
{
    //NSDate *date = [NSDate date]; // 2012-12-28 09:46:31 +0000
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    if(interval!=0){
        [components setDay:interval];
    }
    
    date = [calendar dateByAddingComponents:components toDate:date options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    
    return [formatter stringFromDate:date];
}
@end
