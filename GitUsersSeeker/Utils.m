//
//  Utils.m
//  Picket
//
//  Created by amayoral on 4/9/14.
//  Copyright (c) 2014 adrianmayoral. All rights reserved.
//

#import "Utils.h"

@implementation Utils

UIStoryboard* mainStoryBoard() {
    
    // Determine device kind
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // iPad
        return [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:[NSBundle mainBundle]];
    } else {
        // iPhone
    }
    
    // Determine retina display
    if ([UIScreen instancesRespondToSelector:@selector(scale)] && UIScreen.mainScreen.scale > 1.0) {
        // Retina
    } else {
        // Non-retina
    }
    
    return [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
}

UIViewController* instantiateVCWithStoryboardIdentifier(NSString *identifier) {
    
    UIStoryboard *storyboard = mainStoryBoard();
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
