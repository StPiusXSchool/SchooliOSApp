//
//  VotingResultsViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 6/5/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "VotingResultsViewController.h"
#import "AWSSimpleDB.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import "JBChartView.h"
#import "JBBarChartView.h"
#import "JBLineChartView.h"

CGFloat const kJBBarChartViewControllerChartHeight = 350.0f;
CGFloat const kJBBarChartViewControllerChartPadding = 10.0f;

@interface ResultItem : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSNumber* value;

@end

@implementation ResultItem

@end

@interface VotingResultsViewController () <JBBarChartViewDataSource, JBBarChartViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *selectedBarInfoLabel;
@property (nonatomic, strong) NSMutableArray* results;
@property (nonatomic, strong) JBBarChartView *barChartView;
@end

@implementation VotingResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.results = [NSMutableArray array];
    
    self.barChartView = [[JBBarChartView alloc] init];
    self.barChartView.frame = CGRectMake(kJBBarChartViewControllerChartPadding, kJBBarChartViewControllerChartPadding*10, self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartHeight);
    self.barChartView.dataSource = self;
    self.barChartView.delegate = self;
    self.barChartView.minimumValue = 0.0f;
    [self.view addSubview:self.barChartView];
}

-(void) viewWillAppear:(BOOL)animated {
    [self.results removeAllObjects];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    [gregorian setLocale:[NSLocale currentLocale]];
    
    NSDate *today = [NSDate date];
    NSDateComponents *nowComponents = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:today];
    
    [nowComponents setWeekday:2]; //Monday
    [nowComponents setWeekOfMonth: [nowComponents weekOfMonth]]; //This week
    [nowComponents setHour:6]; //6a.m.
    [nowComponents setMinute:0];
    [nowComponents setSecond:0];
    
    NSDate *mondayOfWeek = [gregorian dateFromComponents:nowComponents];
    
    MBProgressHUD *loadingHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [loadingHUD setMode:MBProgressHUDModeIndeterminate];
    [loadingHUD setLabelText:@"Loading Results..."];
    
    AWSSimpleDB *sdb = [AWSSimpleDB defaultSimpleDB];
    AWSSimpleDBSelectRequest *selectRequest = [AWSSimpleDBSelectRequest new];
    selectRequest.selectExpression = [NSString stringWithFormat:@"select * from `%@` where Time > '%f'", @"TCBY", [mondayOfWeek timeIntervalSince1970] ];
    [sdb select:selectRequest completionHandler:^(AWSSimpleDBSelectResult * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", response.items);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingHUD hide:YES];
            
            NSMutableDictionary* resultsMap = [NSMutableDictionary dictionary];
            
            for (AWSSimpleDBItem* item in response.items) {
                for (AWSSimpleDBAttribute* attr in item.attributes) {
                    if ([attr.name isEqualToString:@"Flavor"]) {
                        NSNumber* count = resultsMap[attr.value];
                        if (count == nil) {
                            count = [NSNumber numberWithInteger:0];
                        }
                        count = [NSNumber numberWithInteger:[count integerValue]+1];
                        resultsMap[attr.value] = count;
                    }
                }
            }
            
            for (NSString* key in resultsMap) {
                ResultItem* resultItem = [[ResultItem alloc] init];
                resultItem.name = key;
                resultItem.value = resultsMap[key];
                [self.results addObject:resultItem];
            }
            [self.barChartView reloadDataAnimated:YES];
        });
    }];
}

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return 8; //self.results.count; // number of bars in chart
}

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
    if (index+1 > self.results.count)
        return;
    
    ResultItem* item = self.results[index];
    NSNumber *valueNumber = item.value;
    
    self.selectedBarInfoLabel.text = [NSString stringWithFormat:@"%@: %ld", item.name, (long)[valueNumber integerValue]];
}

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    if (index+1 > self.results.count)
        return 0.0;
    
    ResultItem* item = self.results[index];
    NSNumber *valueNumber = item.value;
    
    return [valueNumber floatValue]; // height of bar at index
}

- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index
{
    return [UIColor colorWithRed:11.0/255.0 green:11.0/255.0 blue:100.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
