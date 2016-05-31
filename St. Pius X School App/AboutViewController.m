//
//  AboutViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 5/10/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "AboutViewController.h"
#import <MapKit/MapKit.h>

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *MapView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // add pin to map and zoom in
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(42.697233, -73.761485);
    myAnnotation.title = @"St. Pius X School";
    myAnnotation.subtitle = @"Loudonville, NY";
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    region.span = span;
    region.center = myAnnotation.coordinate;
    
    [self.MapView addAnnotation:myAnnotation];
    [self.MapView setRegion:region animated:TRUE];
    [self.MapView regionThatFits:region];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end

