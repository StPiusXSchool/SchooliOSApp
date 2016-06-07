//
//  MainContactsViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 5/10/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "MainContactsViewController.h"
#import "GradeContactsViewController.h"

static NSString* PRE_K = @"PreK";
static NSString* KINDERGARTEN = @"Kindergarten";
static NSString* FIRST_GRADE = @"1st";
static NSString* SECOND_GRADE = @"2nd";
static NSString* THIRD_GRADE = @"3rd";
static NSString* FOURTH_GRADE = @"4th";
static NSString* FIFTH_GRADE = @"5th";
static NSString* SIXTH_SEVENTH_EIGHTH_GRADE = @"6th/7th/8th";
static NSString* SPECIAL_AREA = @"Special Area";


@interface MainContactsViewController ()

@property (nonatomic, strong) NSString* selectedGrade;

@end

@implementation MainContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)principalPhoneClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://15184654539"]];
}
- (IBAction)principalEmailClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://principal@nycap.rr.com"]];
}
- (IBAction)assistantPrincipalPhoneClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://15184654539"]];
}
- (IBAction)assistantPrincipalEmailClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://dcox@stpius-x.com"]];
}
- (IBAction)officePhoneClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://15184654539"]];
}
- (IBAction)officeEmailClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://cmullahy@stpius-x.com"]];
}
- (IBAction)officePhone2Clicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://15184654539"]];
}
- (IBAction)officeEmail2Clicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://mbrunell@stpius-x.com"]];
}

- (IBAction)preKClicked:(id)sender {
    self.selectedGrade = PRE_K;
    
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}

- (IBAction)kindergartenClicked:(id)sender {
    self.selectedGrade = KINDERGARTEN;
    
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}

- (IBAction)firstClicked:(id)sender {
    self.selectedGrade = FIRST_GRADE;
    
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}

- (IBAction)secondClicked:(id)sender {
    self.selectedGrade = SECOND_GRADE;
    
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}

- (IBAction)thirdClicked:(id)sender {
    self.selectedGrade = THIRD_GRADE;
    
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}

- (IBAction)fourthClicked:(id)sender {
    self.selectedGrade = FOURTH_GRADE;
    
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}

- (IBAction)fifthClicked:(id)sender {
    self.selectedGrade = FIFTH_GRADE;
    
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}

- (IBAction)sixthThroughEighthClicked:(id)sender {
    self.selectedGrade = SIXTH_SEVENTH_EIGHTH_GRADE;
    
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}
- (IBAction)specialAreaClicked:(id)sender {
    self.selectedGrade = SPECIAL_AREA;
 
    [self performSegueWithIdentifier:@"ShowGradeContacts" sender:sender];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using
    GradeContactsViewController* vc = [segue destinationViewController];
    // Pass the selected object to the new view controller.
    vc.selectedGrade = self.selectedGrade;
}

@end
