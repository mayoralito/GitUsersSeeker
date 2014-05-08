//
//  BaseUsersModel.h
//  GitUsersSeeker
//
//  Created by amayoral on 5/7/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseUsersModel : NSObject

/** Avatar url of user*/
@property (nonatomic, strong) NSString*     avatar_url;

/** Bio of user*/
@property (nonatomic, strong) NSString*     bio;

/** blog of user*/
@property (nonatomic, strong) NSString*     blog;

/** company of user*/
@property (nonatomic, strong) NSString*     company;

/** created_at of user*/
@property (nonatomic, strong) NSString*     created_at;

/** email of user*/
@property (nonatomic, strong) NSString*     email;

/** Bio of user*/
@property (nonatomic, strong) NSString*     events_url;

/** number of followers by user*/
@property (nonatomic, readwrite) double     followers;

/** Bio of user*/
@property (nonatomic, strong) NSString*     followers_url;

/** number of people following user*/
@property (nonatomic, readwrite) double     following;

/** following_url of user*/
@property (nonatomic, strong) NSString*     following_url;

/** gists_url of user*/
@property (nonatomic, strong) NSString*     gists_url;

/** gravatar_id of user*/
@property (nonatomic, strong) NSString*     gravatar_id;

/** hireable of user*/
@property (nonatomic, readwrite) double     hireable;

/** html_url of user*/
@property (nonatomic, strong) NSString*     html_url;

/** userid (id) of user*/
@property (nonatomic, readwrite) double     userid;

/** location of user (string) */
@property (nonatomic, strong) NSString*     location;

/** login of user*/
@property (nonatomic, strong) NSString*     login;

/** name of user*/
@property (nonatomic, strong) NSString*     name;

/** organizations_url of user*/
@property (nonatomic, strong) NSString*     organizations_url;

/** public_gists of user*/
@property (nonatomic, readwrite) double     public_gists;

/** public_repos of user*/
@property (nonatomic, readwrite) double     public_repos;

/** received_events_url of user*/
@property (nonatomic, strong) NSString*     received_events_url;

/** repos_url of user*/
@property (nonatomic, strong) NSString*     repos_url;

/** site_admin of user 0|1*/
@property (nonatomic, strong) NSString*     site_admin;

/** starred_url of user struct */
@property (nonatomic, strong) NSString*     starred_url;

/** subscriptions_url of user*/
@property (nonatomic, strong) NSString*     subscriptions_url;

/** Type of user*/
@property (nonatomic, strong) NSString*     typeOf;

/** last update of user*/
@property (nonatomic, strong) NSString*     updated_at;

/** url of user*/
@property (nonatomic, strong) NSString*     url;

@end
