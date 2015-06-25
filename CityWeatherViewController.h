//
//  CityWeatherViewController.h
//  Forecastering
//
//  Created by Apple on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface CityWeatherViewController : UIViewController

@property (strong, nonatomic) City *aCity;
@property (nonatomic, weak) IBOutlet UILabel *labelCurrentTemperature;
@property (nonatomic, weak) IBOutlet UILabel *labelFeelsLikeTemperature;
@property (nonatomic, weak) IBOutlet UILabel *labelDewPoint;
@property (nonatomic, weak) IBOutlet UILabel *labelHumidity;
@property (nonatomic, weak) IBOutlet UILabel *labelChanceOfRain;
@property (nonatomic, weak) IBOutlet UILabel *labelWindSpeedMPH;
@property (nonatomic, weak) IBOutlet UILabel *labelVisibility;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;

@end
