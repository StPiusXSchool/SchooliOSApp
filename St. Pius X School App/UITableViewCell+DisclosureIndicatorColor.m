//
//  NSObject+UITableViewCell_DisclosureIndicatorColor.m
//  St. Pius X School App
//
//  Created by Chris Bick on 6/6/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "UITableViewCell+DisclosureIndicatorColor.h"

@implementation UITableViewCell (DisclosureIndicatorColor)

- (void)updateDisclosureIndicatorColorToTintColor {
    [self setDisclosureIndicatorColor:self.window.tintColor];
}

- (void)setDisclosureIndicatorColor:(UIColor *)color {
    NSAssert(self.accessoryType == UITableViewCellAccessoryDisclosureIndicator,
             @"accessory type needs to be UITableViewCellAccessoryDisclosureIndicator");
    
    UIButton *arrowButton = [self arrowButton];
    UIImage *image = [arrowButton backgroundImageForState:UIControlStateNormal];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    arrowButton.tintColor = color;
    [arrowButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (UIColor *)disclosureIndicatorColor {
    NSAssert(self.accessoryType == UITableViewCellAccessoryDisclosureIndicator,
             @"accessory type needs to be UITableViewCellAccessoryDisclosureIndicator");
    
    UIButton *arrowButton = [self arrowButton];
    return arrowButton.tintColor;
}

- (UIButton *)arrowButton {
    for (UIView *view in self.subviews)
        if ([view isKindOfClass:[UIButton class]])
            return (UIButton *)view;
    return nil;
}

@end
