//
//  UIImage+Helper.h
//  Picket
//
//  Created by Jay Quiambao on 2/12/14.
//  Copyright (c) 2014 Internet Brands. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

+(UIImage *)imageFromColorHexString:(NSString *)hex;
+(UIImage *)imageFromColor:(UIColor *)color;
+(UIImage *)imageFromLayer:(CALayer *)layer;
+(UIImage *)imageWithGradient:(CAGradientLayer *)customGradiente withFrame:(CGRect )withFrame;

@end
