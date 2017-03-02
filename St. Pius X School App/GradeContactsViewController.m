//
//  GradeContactsViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 6/3/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "GradeContactsViewController.h"
#import "Contact.h"

@interface GradeContactsViewController ()

@property (nonatomic, strong) NSMutableArray* contactsForGrade;

@end

@implementation GradeContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.selectedGrade;
    
    self.contactsForGrade = [NSMutableArray array];
                     
    NSBundle* myBundle = [NSBundle mainBundle];
    NSString* filePath = [myBundle pathForResource:@"Contacts" ofType:@"csv"];
    NSError* error = nil;
    NSString* contactsStr = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];
    NSArray<NSString *>* contactsArray = [contactsStr componentsSeparatedByString:@"\r"];    
    for (NSString* contactLine in contactsArray) {
        NSArray<NSString *>* contactPartsArray = [contactLine componentsSeparatedByString:@","];
        if (contactPartsArray.count==3){
            Contact* contact = [[Contact alloc]init];
            contact.grade = contactPartsArray[0];
            contact.name = contactPartsArray[1];
            contact.email = contactPartsArray[2];
        
            if ([contact.grade containsString:self.selectedGrade])
                [self.contactsForGrade addObject:contact];
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactsForGrade.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    Contact* contact = self.contactsForGrade[indexPath.row];

    cell.textLabel.text = contact.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Contact* contact = self.contactsForGrade[indexPath.row];
    
    NSString* emailUrl = [NSString stringWithFormat:@"mailto://%@", contact.email];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailUrl]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
