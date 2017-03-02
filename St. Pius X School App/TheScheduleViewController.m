//
//  TheScheduleViewController.m
//  St. Pius X School App
//
//  Created by App Development Team on 2/2/17.
//  Copyright © 2017 St. Pius X School. All rights reserved.
//

#import "TheScheduleViewController.h"

@interface TheScheduleViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *scheduleImageView;

@end

@implementation TheScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage* image  = [UIImage imageNamed:self.pathToSchedule];
    self.scheduleImageView.image = image;
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
