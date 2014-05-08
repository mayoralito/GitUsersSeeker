
//  HudUtil.m
//  Picket
//
//  Created by Jay Quiambao on 2/18/14.
//  Copyright (c) 2014 Internet Brands. All rights reserved.
//

#import "HudUtil.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@implementation HudUtil

+(void)clearAndShowMessage:(NSString*)text {
    [self clear];
    [self showMessage:text];
}

+(void)clearAndShowMessage:(NSString*)text detail:(NSString*)detailText {
    [self clear];
    [self showMessage:text detail:detailText];
}

+(void)showMessage:(NSString*)text {
    [self showMessage:text detail:nil];
}


+(void)showMessage:(NSString*)text detail:(NSString*)detailText {
    
    if(DEV_SKIP_NETWORK) {
        return;
    }
    
    MBProgressHUD* hud = [self sharedHud];
    [hud show:YES];
    hud.dimBackground = YES;
    hud.labelText = text;
    
    if(detailText) {
        hud.detailsLabelText = detailText;
    } else {
        hud.detailsLabelText = nil;
    }
}

+(void)showMessageThenHide:(NSString*)text {
    [self showMessageThenHide:text detail:nil];
}

+(void)showMessageThenHide:(NSString*)text detail:(NSString*)detailText {
    [self showMessage:text detail:detailText];
    [self hide];
}

+(void)showMessageThenDelayHide:(NSString*)text detail:(NSString*)detailText {
    [self showMessage:text detail:detailText];
    [self hideWithDelay:2.0f];
}
+(void)showMessageThenDelayHide:(NSString*)text detail:(NSString*)detailText withDelay:(float)dealy{
    [self showMessage:text detail:detailText];
    [self hideWithDelay:dealy];
}

+(void)hide {
    [self hideWithDelay:0.5f];
}

+(void)hideNow {
    [self hideWithDelay:0.0f];
}

+(void)hideWithDelay:(float)delay {
    MBProgressHUD* hud = [self sharedHud];
    [hud hide:YES afterDelay:delay];
}

+(MBProgressHUD*)sharedHud {
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    MBProgressHUD* hud = [MBProgressHUD HUDForView:delegate.window];
    if(hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
    }
    
    return hud;
}

+(void)clear {
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [MBProgressHUD hideAllHUDsForView:delegate.window animated:NO];
}


@end
