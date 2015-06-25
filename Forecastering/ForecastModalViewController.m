//
//  ForecastModalViewController.m
//  Forecastering
//
//  Created by Apple on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ForecastModalViewController.h"
#import "ForecasteringTableViewController.h"


#import "ForecastCell.h"

#import "NetworkManager.h"

@import CoreLocation;
@import MapKit;
@import AddressBook;

@interface ForecastModalViewController ()<UITextFieldDelegate, NSURLSessionDataDelegate, CLLocationManagerDelegate>
{
//    NSArray *modalWeatherData;
//    NSString *modalZipcode;
//    NSMutableData *modalReceivedData;
    CLLocationManager *locationManager;
    CLGeocoder *geoCoder;
}

- (IBAction)findLocationButton:(UIButton *)sender;

//- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *modalZipCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

- (IBAction)findCityWithCurrentLocation:(UIButton *)sender;


@end

@implementation ForecastModalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.prompt = @"Enter Your Zip Code";
    geoCoder = [[CLGeocoder alloc] init];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocation related methods

- (void)configureLocationManager
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!locationManager)
        {
            locationManager =[[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
    }
    else
    {
        [self.currentLocationButton setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.currentLocationButton setEnabled:NO];
    }
    else
    {
        [self enableLocationManager:YES];
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (locationManager)
    {
        if (enable)
        {
            [locationManager stopUpdatingLocation];
            [locationManager startUpdatingLocation];
        }
        else
        {
            [locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error != kCLErrorLocationUnknown)
    {
        [self enableLocationManager:NO];
        [self.currentLocationButton setEnabled:NO];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if ((placemarks != nil) && (placemarks.count > 0))
        {
            [self enableLocationManager:NO];
            NSString *cityName = [placemarks[0] locality];
            NSString *zipCode = [[placemarks[0] addressDictionary] objectForKey:(NSString *)kABPersonAddressZIPKey];
//            NSString *state = [[placemarks[0] addressDictionary] objectForKey:(NSString *)kABPersonAddressStateKey];
            double lat = location.coordinate.latitude;
            double lng = location.coordinate.longitude;
            City *aCity = [[City alloc] initWithName:cityName latitude:lat longitude:lng andZipCode:zipCode];
            [[NetworkManager sharedNetworkManager] cityFoundUsingCurrentLocation:aCity];
        }
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

#pragma mark - Action Handlers

- (IBAction)findLocationButton:(UIButton *)sender
{
    
    if (![self.modalZipCodeTextField.text isEqualToString:@""])
    {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        if ([self.modalZipCodeTextField.text length] == 5 && [self.modalZipCodeTextField.text rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            [self.modalZipCodeTextField resignFirstResponder];
            City *aCity = [[City alloc] initWithZipCode:self.modalZipCodeTextField.text];
            
            [[NetworkManager sharedNetworkManager] findCoordinatesForCity:aCity];
        }
    }
}

- (IBAction)findCityWithCurrentLocation:(UIButton *)sender
{
    [self configureLocationManager];
}















@end
