//
//  ViewController.h
//  GitUsersSeeker
//
//  Created by amayoral on 5/7/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailUserViewController;
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DetailUserViewController *detailUserViewController;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, readwrite) double since;
- (IBAction)showProfile:(id)sender;

@end
