//
//  EventsTableViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 5/10/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "EventsTableViewController.h"
#import "EventDetailsViewController.h"
#import "MXLCalendarManager.h"
#import "MBProgressHUD.h"

@interface EventsTableViewController ()

@property (nonatomic, retain) MXLCalendar* currentCalendar;

@end

@implementation EventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MXLCalendarManager *calendarManager = [[MXLCalendarManager alloc] init];
    
    MBProgressHUD *loadingHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [loadingHUD setMode:MBProgressHUDModeIndeterminate];
    [loadingHUD setLabelText:@"Loading Events..."];
    
    [calendarManager scanICSFileAtRemoteURL:[NSURL URLWithString:@"http://www.stpius-x.com/more-events?task=ical.download&id=17"]
                      withCompletionHandler:^(MXLCalendar *calendar, NSError *error) {
                          //currentCalendar = [[MXLCalendar alloc] init];
                          self.currentCalendar = calendar;
                          NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
                          NSInteger year = [components year];
                          
                          NSMutableArray* toBeRemoved = [NSMutableArray array];
                          for (MXLCalendarEvent* event in self.currentCalendar.events) {
                              components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:event.eventStartDate];
                              NSInteger eventYear = [components year];
                              if (year != eventYear)
                                  [toBeRemoved addObject:event];
                              
                          }
                          [self.currentCalendar.events removeObjectsInArray:toBeRemoved];
                          
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [loadingHUD hide:YES];
                              [self.tableView reloadData];
                          });
                      }
    ];
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return (self.currentCalendar == nil ? 0 : self.currentCalendar.events.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    
    MXLCalendarEvent* event = self.currentCalendar.events[indexPath.row];
    cell.textLabel.text = [event eventSummary];
    
    // the date from ics file says UTC but it's really EST
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    if (event.eventIsAllDay) {
        NSTimeInterval start = [event.eventStartDate timeIntervalSince1970];
        NSTimeInterval end = [event.eventEndDate timeIntervalSince1970];
        // if start and end is one day don't show range
        if (end - start == 60*60*24) {
            NSString* startDate = [dateFormatter stringFromDate:event.eventStartDate];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", startDate];
        } else {
            NSString* startDate = [dateFormatter stringFromDate:event.eventStartDate];
            NSString* endDate = [dateFormatter stringFromDate:event.eventEndDate];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
        }
    } else {
        NSString* date = [dateFormatter stringFromDate:event.eventStartDate];
        [dateFormatter setDateFormat:@"hh:mm a"];
        NSString* startTime = [dateFormatter stringFromDate:event.eventStartDate];
        NSString* endTime = [dateFormatter stringFromDate:event.eventEndDate];
    
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", date, startTime, endTime];
    }
    
    //[dateFormatter setDateFormat:@"hh:mm a"];
    //cell.detailTextLabel.text = [dateFormatter stringFromDate:event.eventStartDate];
                               
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    EventDetailsViewController* vc = [segue destinationViewController];
    
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    MXLCalendarEvent* event = self.currentCalendar.events[selectedIndexPath.row];
    vc.selectedEvent = event;
}

@end
