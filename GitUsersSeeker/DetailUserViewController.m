//
//  DetailUserViewController.m
//  GitUsersSeeker
//
//  Created by amayoral on 5/8/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import "DetailUserViewController.h"
#import "UIColor+Hex.h"

#import "UsersManager.h"
#import "UserModel.h"

@interface DetailUserViewController (){
    UsersManager *__usersManager;
}

@end

@implementation DetailUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor UIColorFromHex:0xffffff];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    if(nil == __usersManager){
        __usersManager = [UsersManager sharedInstance];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"login: %@", _login);
    
    [__usersManager getUsers:[NSString stringWithFormat:@"users/%@", _login]
                  withParams:nil
                     success:^(NSDictionary *data, NSHTTPURLResponse *urlResponse) {
                         NSLog(@"_login: %@", data);
                     } error:^(NSDictionary *responseObject, NSString *errorMessage) {
                         NSLog(@"Error with something");
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
