//
//  VotingViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 5/10/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "VotingViewController.h"
#import "AWSSimpleDB.h"
#import "MBProgressHUD.h"

@interface VotingViewController ()

@end

@implementation VotingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
    AWSSimpleDB *sdb = [AWSSimpleDB defaultSimpleDB];
    AWSSimpleDBSelectRequest *selectRequest = [AWSSimpleDBSelectRequest new];
    selectRequest.selectExpression = [NSString stringWithFormat:@"select * from `%@` where Time < '%f'", @"TCBY", [[NSDate date] timeIntervalSince1970] ];
    [sdb select:selectRequest completionHandler:^(AWSSimpleDBSelectResult * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", response.items);
    }];
    
    AWSSimpleDBCreateDomainRequest *createDomainRequest = [AWSSimpleDBCreateDomainRequest new];
    createDomainRequest.domainName = @"TCBY";
    [sdb createDomain:createDomainRequest completionHandler:^(NSError * _Nullable error) {
        NSLog(@"Create domain success");
    }];
    
    AWSSimpleDBListDomainsRequest* listDomainRequest = [AWSSimpleDBListDomainsRequest new];
    [sdb listDomains:listDomainRequest completionHandler:^(AWSSimpleDBListDomainsResult * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Domain names: %@", response.domainNames);
    }];
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CookiesAndCClicked:(UIButton *)sender {
    [self voteWithFlavor:sender.titleLabel.text];
}

- (IBAction)CakeBClicked:(UIButton *)sender {
    [self voteWithFlavor:sender.titleLabel.text];
}
- (IBAction)ChocolateClicked:(UIButton *)sender {
    [self voteWithFlavor:sender.titleLabel.text];
}
- (IBAction)VanillaClicked:(UIButton *)sender {
    [self voteWithFlavor:sender.titleLabel.text];
}
- (IBAction)StrawberryClicked:(UIButton *)sender {
    [self voteWithFlavor:sender.titleLabel.text];
}
- (IBAction)CaramelClicked:(UIButton *)sender {
    [self voteWithFlavor:sender.titleLabel.text];
}
- (IBAction)TMarshmallowClicked:(UIButton *)sender {
    [self voteWithFlavor:sender.titleLabel.text];
}
- (IBAction)WCMousseClicked:(UIButton *)sender {
    [self voteWithFlavor:sender.titleLabel.text];
}

- (IBAction)viewResultsClicked:(id)sender {
    [self performSegueWithIdentifier:@"VotingResultsSegue" sender:nil];
}

- (void) voteWithFlavor:(NSString*)flavor {
    MBProgressHUD *loadingHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [loadingHUD setMode:MBProgressHUDModeIndeterminate];
    [loadingHUD setLabelText:@"Sending Vote..."];
    
    AWSSimpleDB *sdb = [AWSSimpleDB defaultSimpleDB];
    
    // add vote to database
    AWSSimpleDBPutAttributesRequest *putAttributesRequest = [AWSSimpleDBPutAttributesRequest new];
    putAttributesRequest.domainName = @"TCBY";;
    putAttributesRequest.itemName = [[NSUUID UUID] UUIDString];
    AWSSimpleDBReplaceableAttribute *attribute1 = [AWSSimpleDBReplaceableAttribute new];
    attribute1.name = @"Flavor";
    attribute1.value = flavor;
    attribute1.replace = @YES;
    AWSSimpleDBReplaceableAttribute *attribute2 = [AWSSimpleDBReplaceableAttribute new];
    attribute2.name = @"Time";
    attribute2.value = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    attribute2.replace = @YES;
    
    putAttributesRequest.attributes = @[attribute1,attribute2];
    [sdb putAttributes:putAttributesRequest completionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingHUD hide:YES];
            
            [self performSegueWithIdentifier:@"VotingResultsSegue" sender:nil];
        });
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
