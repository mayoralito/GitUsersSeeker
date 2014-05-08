//
//  UsersManager.m
//  GitUsersSeeker
//
//  Created by amayoral on 5/7/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import "UsersManager.h"
#import "HudUtil.h"
#import "AppDelegate.h"
#import "Compression.h"
#import "NSDictionary+JSON.h"

@implementation UsersManager
static id shared = NULL;

+(instancetype)sharedInstance {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

-(void)getUsers:(NSString*)method
     withParams:(NSDictionary *)params
        success:(APIRequestSuccess)success
          error:(APIRequestError)error{
    [HudUtil clearAndShowMessage:@"Searching..."];
    
    [self get:method params:params addParams:NO success:^(NSDictionary *data, NSHTTPURLResponse *urlResponse) {
        /*
        NSString *jsonString = nil;
        
        if(nil != data){
            jsonString = [[NSString alloc] initWithData:[(NSData *)data gzipInflate] encoding:NSUTF8StringEncoding];
            data = @{@"data" : [NSDictionary stringAsDictionary:jsonString]};
        }else{
            data = @{@"data" : @{} };
        }*/
        
        [HudUtil hide];
        success(data, urlResponse);
        
    } error:^(NSDictionary *responseObject, NSString *errorMessage) {
        
        
        [HudUtil showMessageThenDelayHide:@"Network error" detail:errorMessage];
        error(responseObject, errorMessage);
    }];
}

@end
