//
//  UsersManager.h
//  GitUsersSeeker
//
//  Created by amayoral on 5/7/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import "APIManager.h"

@interface UsersManager : APIManager
+(instancetype)sharedInstance;
-(void)getUsers:(NSString*)method
     withParams:(NSDictionary *)params
        success:(APIRequestSuccess)success
          error:(APIRequestError)error;
@end
