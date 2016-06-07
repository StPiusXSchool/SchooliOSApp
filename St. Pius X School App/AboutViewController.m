//
//  AboutViewController.m
//  St. Pius X School App
//
//  Created by Chris Bick on 5/10/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import "AboutViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // request permission for current location
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    
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
}

- (IBAction)callOfficeClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://15184654539"]];
}

- (IBAction)directionsClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://maps.apple.com/?daddr=72+Upper+Loudon+Road+Loudonville,+New+York+12211"]];
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

