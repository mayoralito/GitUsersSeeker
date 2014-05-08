//
//  APIManager.h
//  GitUsersSeeker
//
//  Created by amayoral on 5/7/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#if DEV_SHOW_API_METHOD_LOG
#   define APILog(fmt, ...) NSLog((@"API %@ " fmt), NSStringFromClass([self class]), ##__VA_ARGS__);
#else
#   define APILog(...)
#endif

#if DEV_SHOW_API_RESPONSE_LOG
#   define APIResLog(fmt, ...) NSLog((@"API %@ " fmt), NSStringFromClass([self class]), ##__VA_ARGS__);
#else
#   define APIResLog(...)
#endif

#if DEV_SHOW_API_REQUEST_LOG
#   define APIReqLog(fmt, ...) NSLog((@"API %@ " fmt), NSStringFromClass([self class]), ##__VA_ARGS__);
#else
#   define APIReqLog(...)
#endif

typedef void (^APIRequestSuccess) (NSDictionary* data, NSHTTPURLResponse* urlResponse);
typedef void (^APIRequestFail) (NSDictionary* data, NSHTTPURLResponse* urlResponse);
typedef void (^APIRequestError) (NSDictionary* responseObject, NSString* errorMessage);
typedef void (^APIXMLRequestSuccess) (NSXMLParser* parser, NSHTTPURLResponse* urlResponse);

@interface APIManager : NSObject
@property BOOL isValid;

-(void)get:(NSString*)method params:(NSDictionary*)params addParams:(BOOL)useOauth
   success:(APIRequestSuccess)success error:(APIRequestError)error;


@end