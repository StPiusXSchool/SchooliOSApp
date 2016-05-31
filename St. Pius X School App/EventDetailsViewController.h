//
//  EventDetailsViewController.h
//  St. Pius X School App
//
//  Created by Chris Bick on 5/27/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MXLCalendarEvent;

@interface EventDetailsViewController : UIViewController

@property (nonatomic, retain) MXLCalendarEvent* selectedEvent;

@end
