//
//  HudUtil.h
//  Picket
//
//  Created by Jay Quiambao on 2/18/14.
//  Copyright (c) 2014 Internet Brands. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HudUtil : NSObject

+(void)clearAndShowMessage:(NSString*)text;
+(void)clearAndShowMessage:(NSString*)text detail:(NSString*)detailText;


+(void)showMessage:(NSString*)text;
+(void)showMessage:(NSString*)text detail:(NSString*)detailText;

+(void)showMessageThenHide:(NSString*)text;
+(void)showMessageThenHide:(NSString*)text detail:(NSString*)detailText;
+(void)showMessageThenDelayHide:(NSString*)text detail:(NSString*)detailText;
+(void)showMessageThenDelayHide:(NSString*)text detail:(NSString*)detailText withDelay:(float)dealy;

+(void)hide;
+(void)hideNow;
+(void)hideWithDelay:(float)delay;

+(void)clear;




@end
