//
//  ViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 5/10/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property(nonatomic) bool fatherClicked;
@property(nonatomic) bool sonClicked;
@property(nonatomic) bool holySpirit1Clicked;
@property(nonatomic) bool holySpirit2Clicked;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    self.fatherClicked = NO;
    self.sonClicked = NO;
    self.holySpirit1Clicked = NO;
    self.holySpirit2Clicked = NO;    
}

- (IBAction)CalendarButton:(id)sender {
}
- (IBAction)TCBYButton:(id)sender {
}
- (IBAction)ContactsButton:(id)sender {
}
- (IBAction)DirectionsButton:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fatherClicked:(id)sender {
    self.fatherClicked = YES;
}

- (IBAction)sonClicked:(id)sender {
    self.sonClicked = YES;
}

- (IBAction)holySpirit1Clicked:(id)sender {
    self.holySpirit1Clicked = YES;
}
- (IBAction)holySpirit2Clicked:(id)sender {
    self.holySpirit2Clicked = YES;
    if (self.fatherClicked && self.sonClicked && self.holySpirit1Clicked && self.holySpirit2Clicked) {
        [self performSegueWithIdentifier:@"EasterEggSegue" sender:sender];
    }
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

@end
