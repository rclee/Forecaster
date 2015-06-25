//
//  City.h
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@import MapKit; //imports a framework - in every class you want to use it in

@interface City : NSObject <MKAnnotation, NSCoding> //implementing the protocol - works similar to a delegate - acting as an MKAnnotation object

@property (strong, nonatomic) Weather *currentWeather;
@property (strong, nonatomic) NSArray *forecastedWeather;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (strong, nonatomic) NSString *zipCode;

- (instancetype)initWithZipCode:(NSString *)zip;
- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipCode:(NSString *)zip;
- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary;
- (CLLocationCoordinate2D)coordinate;


@end
