//
//  APIManager.m
//  GitUsersSeeker
//
//  Created by amayoral on 5/7/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"

@implementation APIManager
{
    AFHTTPRequestOperationManager *manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isValid = YES;
        manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:BASE_URL];
        manager.securityPolicy.allowInvalidCertificates = YES;
        
        //NSMutableSet* mset = [manager.responseSerializer.acceptableContentTypes mutableCopy];
        //[mset addObject:@"text/html"];
        //manager.responseSerializer.acceptableContentTypes = mset;
        
        
    }
    return self;
}

/**
 *  GET
 */
-(void)get:(NSString *)method
    params:(NSDictionary *)params
 addParams:(BOOL)useOauth
   success:(APIRequestSuccess)success
     error:(APIRequestError)error {
    [self get:method params:params addParams:useOauth success:success fail:nil error:error];
}


-(void)get:(NSString*)method
    params:(NSDictionary*)params
 addParams:(BOOL)useOauth
   success:(APIRequestSuccess)success
      fail:(APIRequestFail)fail
     error:(APIRequestError)error {
    
    if(DEV_SKIP_NETWORK) {
        return;
    }
    
    //NSString* fullMethod = [NSString stringWithFormat:@"%@%@", API_VERSION, method];
    NSString* fullMethod = [NSString stringWithFormat:@"/%@", method];
    //NSLog(@"[GET] %@%@", BASE_URL, fullMethod);
    //NSLog(@"[PARAMS] %@", params);
    
    [manager GET:fullMethod
      parameters:params
         success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
             
             //NSLog(@"[SUCCESS] %@%@", BASE_URL, fullMethod);
             //NSLog(@"[SUCCESS] %@", operation.responseString);
             
             if(!self.isValid) {
                 [operation cancel];
                 return;
             }
             
             if(nil != responseObject) {
                 //NSLog(@"[SUCCESS] %@", responseObject);
                 success(responseObject, operation.response);
             } else {
                 fail(responseObject, operation.response);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *_error) {
             
             NSLog(@"[FAILURE] %@%@", BASE_URL, fullMethod);
             NSLog(@"[FAILURE] %@", operation.responseString);
             
             if(!self.isValid) {
                 return;
             }
             
             if(![operation.responseObject isKindOfClass:[NSDictionary class]]) {
                 NSLog(@"[API ERROR] API returned none JSON response.");
                 NSLog(@"[RES HEADERS] %@", [operation.response allHeaderFields]);
                 NSLog(@"[FAILURE] %@", _error);
             }
             
             NSString* errorMessage = @"Error message not defined.";
             @try {
                 errorMessage = [operation.responseObject valueForKey:@"message"];
             }
             @finally {
                 error(operation.responseObject, errorMessage);
             }
             
         }];
    
    [[manager.operationQueue.operations firstObject] setRedirectResponseBlock:^NSURLRequest *(NSURLConnection *connection, NSURLRequest *request, NSURLResponse *redirectResponse) {
        return request;
    }];
}

/**
 *  Handles SUCCESS and FAIL for GET and POST.
 *
 *  Note: FAIL could be a HTTP 200 but with "status" value of "fail"
 *
 *  @param success
 *  @param fail
 *  @param operation
 *  @param responseObject
 */
-(void)processSuccess:(APIRequestSuccess)success andFail:(APIRequestFail)fail operation:(AFHTTPRequestOperation*) operation resonpse:(id) responseObject {
    
    
    BOOL status = [[responseObject valueForKey:@"status"] isEqualToString:@"success"];
    
    if(status) {
        //NSLog(@"[SUCCESS] %@", [operation.request.URL standardizedURL]);
        //NSLog(@"[SUCCESS] %@", operation.responseString);
        success([responseObject valueForKey:@"data"], operation.response);
        
    } else {
        NSLog(@"[FAIL] %@", [operation.request.URL standardizedURL]);
        NSLog(@"[FAIL] %@", operation.responseString);
        fail([responseObject valueForKey:@"data"], operation.response);
    }
}

/**
 *  Handles all errors for POST and GET
 *
 *  @param error
 *  @param operation
 *  @param _error
 */
-(void)processError:(APIRequestError)error operation:(AFHTTPRequestOperation*)operation error:(NSError*)_error {
    
    if(![operation.responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"[API ERROR] API returned none JSON response.");
        NSLog(@"[RES HEADERS] %@", [operation.response allHeaderFields]);
        NSLog(@"[FAILURE] %@", [_error description]);
    }
    
    NSString* errorMessage = @"Error message not defined.";
    @try {
        errorMessage = [operation.responseObject valueForKey:@"message"];
    }
    
    @finally {
        
        if(errorMessage == nil) {
            errorMessage = @"API returned none JSON response.";
        }
        
        error(operation.responseObject, errorMessage);
    }
}


/**
 *  Invalidate current operation
 */
-(void)invalidate {
    self.isValid = NO;
}


@end
