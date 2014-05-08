//
//  Utils.h
//  Picket
//
//  Created by amayoral on 4/9/14.
//  Copyright (c) 2014 adrianmayoral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

#pragma mark - Storyboards
UIStoryboard* mainStoryBoard();
UIViewController* instantiateVCWithStoryboardIdentifier(NSString *identifier);

@end
