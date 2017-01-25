//
//  MainScheduleViewController.m
//  St. Pius X School App
//
//  Created by App Development Team on 1/20/17.
//  Copyright © 2017 St. Pius X School. All rights reserved.
//

#import "MainScheduleViewController.h"
#import "Contact.h"
#import "ScheduleTeachersViewController.h"

@interface MainScheduleViewController ()

@end

@implementation MainScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)prekAction:(id)sender {
    self.selectedGrade = PRE_K;
    
    [self performSegueWithIdentifier:@"ShowTeachersSegue" sender:sender];
}

#pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using
     ScheduleTeachersViewController* vc = [segue destinationViewController];
     // Pass the selected object to the new view controller.
     vc.selectedGrade = self.selectedGrade;
 }
@end
