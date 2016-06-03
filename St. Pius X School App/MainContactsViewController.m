//
//  MainContactsViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 5/10/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "MainContactsViewController.h"

@interface MainContactsViewController ()

@end

@implementation MainContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)principalPhoneClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://2135554321"]];
}
- (IBAction)principalEmailClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://2135554321"]];
}
- (IBAction)assistantPrincipalPhoneClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://2135554321"]];
}
- (IBAction)assistantPrincipalEmailClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://2135554321"]];
}
- (IBAction)officePhoneClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://2135554321"]];
}
- (IBAction)officeEmailClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://2135554321"]];
}
- (IBAction)PreKClicked:(id)sender {
}
- (IBAction)KindergartenClicked:(id)sender {
}
- (IBAction)Firstclicked:(id)sender {
}
- (IBAction)SecondClicked:(id)sender {
}
- (IBAction)ThirdClicked:(id)sender {
}
- (IBAction)FourthClicked:(id)sender {
}
- (IBAction)FifthClicked:(id)sender {
}
- (IBAction)SixthThroughEighthClicked:(id)sender {
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
