//
//  City.m
//  Forecastering
//
//  Created by Apple on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "City.h"

@interface City ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation City

- (instancetype)initWithZipCode:(NSString *)zip;
{
    self = [super init];
    if (self)
    {
        _zipCode = zip;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipCode:(NSString *)zip;
{
    self = [super init];
    if (self)
    {
        _zipCode = zip;
        _latitude = lat;
        _longitude = lng;
        _name = name;
        _coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    return self;
}

- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary;
{
    BOOL rc = NO;
    if (mapsDictionary)
    {
        NSArray *results = [mapsDictionary objectForKey:@"results"];
        NSDictionary *locationInfo = [results objectAtIndex:0];
        NSArray *addressComps = [locationInfo objectForKey:@"address_components"];
        NSDictionary *city = [addressComps objectAtIndex:1];
        self.name = [city objectForKey:@"long_name"]; // user comment 11
        NSDictionary *state = [addressComps objectAtIndex:2];
        self.state = [state objectForKey:@"short_name"];
        NSDictionary *geometry = [locationInfo objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        self.latitude = [[location objectForKey:@"lat"] doubleValue];
        self.longitude = [[location objectForKey:@"lng"] doubleValue];
        self.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
            rc = YES;
    }
    return rc;
}



- (NSString *)title //built in method being overwritten for MKAnnotation
{
    return self.name;
}

- (NSString *)subtitle
{
    return [self.currentWeather currentTemperature];
}

- (CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

- (MKMapItem *)mapItem
{
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.name; // user comment 11
    
    return mapItem;
}

#pragma mark - NSCoding

#define kNameKey @"name"
#define kZipCodeKey @"zipCode"
#define kLatitudeKey @"latitude"
#define kLongitudeKey @"longitude"


- (void)encodeWithCoder:(NSCoder *)aCoder //NSCoding protocol RCL: HW
{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeObject:self.zipCode forKey:kZipCodeKey];
    [aCoder encodeDouble:self.latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:self.longitude forKey:kLongitudeKey];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    NSString *cityName = [aDecoder decodeObjectForKey:kNameKey];
    NSString *zipCode = [aDecoder decodeObjectForKey:kZipCodeKey];
    double latitude = [aDecoder decodeDoubleForKey:kLatitudeKey];
    double longitude = [aDecoder decodeDoubleForKey:kLongitudeKey];
    return [self initWithName:cityName latitude:latitude longitude:longitude andZipCode:zipCode];
}






























@end
