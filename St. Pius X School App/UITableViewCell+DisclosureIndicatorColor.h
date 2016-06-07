//
//  NSObject+UITableViewCell_DisclosureIndicatorColor.h
//  St. Pius X School App
//
//  Created by Chris Bick on 6/6/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableViewCell (DisclosureIndicatorColor)

@property (nonatomic, strong) UIColor *disclosureIndicatorColor;
- (void)updateDisclosureIndicatorColorToTintColor;

@end
