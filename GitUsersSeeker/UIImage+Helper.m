//
//  UIImage+Helper.m
//  Picket
//
//  Created by Jay Quiambao on 2/12/14.
//  Copyright (c) 2014 Internet Brands. All rights reserved.
//

#import "UIImage+Helper.h"
#import "UIColor+Hex.h"

@implementation UIImage (Helper)


+(UIImage *)imageFromColorHexString:(NSString *)hex {
    return [self imageFromColor:[UIColor colorWithHexString:hex]];
}

+(UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIImage *)imageFromLayer:(CALayer *)layer
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions([layer frame].size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext([layer frame].size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+(UIImage *)imageWithGradient:(CAGradientLayer *)customGradiente withFrame:(CGRect )withFrame
{
    
    UIView *captureView = [[UIView alloc] initWithFrame:withFrame];
    /* Add to view - gradient */
    CAGradientLayer *bgLayer = customGradiente;
	bgLayer.frame = captureView.bounds;
    [captureView.layer insertSublayer:bgLayer atIndex:0];
    
    /* Capture the screen shoot at native resolution */
    UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, captureView.opaque, 0.0);
    [captureView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    /* Render the screen shot at custom resolution */
    CGRect cropRect = withFrame;
    UIGraphicsBeginImageContextWithOptions(cropRect.size, captureView.opaque, 1.0f);
    [screenshot drawInRect:cropRect];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


@end
