//
//  EventDetailsViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 5/27/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "EventDetailsViewController.h"
#import <EventKit/EventKit.h>
#import "MXLCalendarEvent.h"

@interface EventDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;

@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventTitle.text = self.selectedEvent.eventSummary;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    if (self.selectedEvent.eventIsAllDay) {
        NSTimeInterval start = [self.selectedEvent.eventStartDate timeIntervalSince1970];
        NSTimeInterval end = [self.selectedEvent.eventEndDate timeIntervalSince1970];
        // if start and end is one day don't show range
        if (end - start == 60*60*24) {
            NSString* startDate = [dateFormatter stringFromDate:self.selectedEvent.eventStartDate];
            self.eventDate.text = [NSString stringWithFormat:@"%@", startDate];
        } else {
            NSString* startDate = [dateFormatter stringFromDate:self.selectedEvent.eventStartDate];
            NSString* endDate = [dateFormatter stringFromDate:self.selectedEvent.eventEndDate];
            self.eventDate.text = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
        }
    } else {
        NSString* date = [dateFormatter stringFromDate:self.selectedEvent.eventStartDate];
        [dateFormatter setDateFormat:@"hh:mm a"];
        NSString* startTime = [dateFormatter stringFromDate:self.selectedEvent.eventStartDate];
        NSString* endTime = [dateFormatter stringFromDate:self.selectedEvent.eventEndDate];
        
        self.eventDate.text = [NSString stringWithFormat:@"%@ %@ - %@", date, startTime, endTime];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToCalendarClicked:(id)sender {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            // code here for when the user allows your app to access the calendar
            EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
            event.title     = self.selectedEvent.eventSummary;
            
            event.startDate = self.selectedEvent.eventStartDate;
            event.endDate   = self.selectedEvent.eventEndDate;
            
            [event setCalendar:[eventStore defaultCalendarForNewEvents]];
            NSError *err;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
            NSLog(@"%@", err.debugDescription);
        } else {
            // code here for when the user does NOT allow your app to access the calendar
        }
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
