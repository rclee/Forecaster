//
//  CityWeatherViewController.m
//  Forecastering
//
//  Created by Apple on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CityWeatherViewController.h"
#import "City.h"

@import MapKit;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344

@interface CityWeatherViewController ()

@end

@implementation CityWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.aCity.name;
    self.iconImageView.image = [UIImage imageNamed:self.aCity.currentWeather.icon];
    self.labelCurrentTemperature.text = [self.aCity.currentWeather currentTemperature];
    self.labelFeelsLikeTemperature.text = [self.aCity.currentWeather feelsLikeTemperature];
    self.labelDewPoint.text = [self.aCity.currentWeather dewPointTemperature];
    self.labelWindSpeedMPH.text = [self.aCity.currentWeather windSpeedMPH];
    self.labelVisibility.text = [self.aCity.currentWeather currentVisibility];
    self.labelChanceOfRain.text = [self.aCity.currentWeather chanceOfRain];
    self.labelHumidity.text = [self.aCity.currentWeather humidityPercentage];
    
    // Do any additional setup after loading the view.
    [self configureMapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.aCity coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion];
    [self.mapView addAnnotation:self.aCity];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[City class]])
    {
        static NSString * const identifier = @"CityAnnotation";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        annotationView.canShowCallout = YES;
        return annotationView; //return is the last thing you do in a method
    }
    return nil;
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
