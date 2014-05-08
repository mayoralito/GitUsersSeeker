//
//  ViewController.m
//  GitUsersSeeker
//
//  Created by amayoral on 5/7/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Hex.h"
#import "UsersManager.h"
#import "DetailUserViewController.h"
#import "SYCache.h"
#import "UsersDBManager.h"

static int items_per_page = 135;

@interface ViewController (){
    NSMutableArray *userList;
    UsersManager *__usersManager;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor UIColorFromHex:0xffffff];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    if(nil == __usersManager){
        __usersManager = [UsersManager sharedInstance];
    }
    userList = [[NSMutableArray alloc] init];
    
    if(nil == _detailUserViewController){
        _detailUserViewController = (DetailUserViewController *)instantiateVCWithStoryboardIdentifier(@"DetailUserViewController");
    }
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    _since = 0;
    
    [self searchAPISince:_since];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchAPISince:(double)since
{
    [__usersManager getUsers:[NSString stringWithFormat:@"users?since=%f", since]
                  withParams:nil
                     success:^(NSDictionary *data, NSHTTPURLResponse *urlResponse) {
                         [userList addObjectsFromArray:(NSArray *)data];
                         [_tableView reloadData];
                         
                         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                             //DO SOME VERY LONG STUFF HERE
                             NSLog(@"try to save");
                             [UsersDBManager storeGitHubUsers:userList];
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 NSLog(@"saved....");
                             });
                         });
                     } error:^(NSDictionary *responseObject, NSString *errorMessage) {
                         NSLog(@"Error with something");
                     }];
}

- (IBAction)showProfile:(id)sender
{
    _detailUserViewController.login = @"mayoralito";
    
    [self.navigationController pushViewController:_detailUserViewController animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    // NSLog(@"offset: %f", offset.y);
    // NSLog(@"content.height: %f", size.height);
    // NSLog(@"bounds.height: %f", bounds.size.height);
    // NSLog(@"inset.top: %f", inset.top);
    // NSLog(@"inset.bottom: %f", inset.bottom);
    // NSLog(@"pos: %f of %f", y, h);
    
    float reload_distance = 10;
    if(y > h + reload_distance) {
        _since++;
        NSLog(@"load more rows: %f", _since*items_per_page);
        [self searchAPISince:_since*items_per_page];
    }
}

#pragma mark - UITableViewDelegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [userList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ListCategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = (UITableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    NSDictionary *gitInfo = [userList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [gitInfo valueForKey:@"login"];
    cell.detailTextLabel.text = (NSString* )[gitInfo valueForKey:@"type"];
    [cell.imageView setImage:nil];
    
    [[SYCache sharedCache] imageWithKey:[[gitInfo valueForKey:@"avatar_url"] lastPathComponent] withFullPath:[gitInfo valueForKey:@"avatar_url"] completionHandler:^(UIImage *image) {
        
        [cell.imageView.layer setBorderWidth:1.0];
        [cell.imageView.layer setBorderColor:[[UIColor grayColor] CGColor]];
        [cell.imageView.layer setCornerRadius:8.0];
        [cell.imageView.layer setMasksToBounds:YES];
        
        [cell.imageView setImage:image];
        [cell.imageView setNeedsLayout];
    }];
    
    //cell.titleLabel.text = @"demo text"; //[self.userList objectAtIndex:[indexPath row]];
    //cell.detailLabel.text = @"demo Detail";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *gitInfo = [userList objectAtIndex:indexPath.row];
    _detailUserViewController.login = [gitInfo valueForKey:@"login"];
    
    [self.navigationController pushViewController:_detailUserViewController animated:YES];
}

@end
