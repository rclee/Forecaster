//
//  Weather.m
//  Forecastering
//
//  Created by Apple on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Weather.h"
#import "ForecasteringTableViewController.h"


@implementation Weather

- (BOOL)parseWeatherInfo:(NSDictionary *)infoDictionary;
{
    BOOL rc = NO;
    if (infoDictionary)
    {
        
    
        NSDictionary *currently = [infoDictionary objectForKey:@"currently"];
        self.temperature = [[currently objectForKey:@"temperature"] doubleValue];
        self.apparentTemperature = [[currently objectForKey:@"apparentTemperature"] doubleValue];
        self.dewPoint = [[currently objectForKey:@"dewPoint"] doubleValue];
        self.humidity = [[currently objectForKey:@"humidity"] doubleValue];
        self.precipProbability = [[currently objectForKey:@"precipProbability"] doubleValue];
        self.windSpeed = [[currently objectForKey:@"windSpeed"] doubleValue];
        self.visibility = [[currently objectForKey:@"visibility"] doubleValue];
        self.summary = [currently objectForKey:@"summary"];
        self.icon = [currently objectForKey:@"icon"];
        NSLog(@"Humid %f", self.humidity);
        NSLog(@"chance of rain %f", self.precipProbability);
        
        rc = YES;
    }
    return rc;
}
                     
- (NSString *)currentTemperature
{
    return [NSString stringWithFormat:@"%.0f°F", self.temperature];
}
- (NSString *)feelsLikeTemperature
{
    return [NSString stringWithFormat:@"Feels Like %.0f°F", self.apparentTemperature];
}
- (NSString *)dewPointTemperature
{
    return [NSString stringWithFormat:@"%.0f°F", self.dewPoint];
}
- (NSString *)humidityPercentage
{
    return [NSString stringWithFormat:@"%.1f%%", self.humidity*100];
}
- (NSString *)chanceOfRain
{
    return [NSString stringWithFormat:@"Chance of Rain %.1f%%", self.precipProbability*100];
}
- (NSString *)windSpeedMPH
{
    return [NSString stringWithFormat:@"%.0f MPH Wind", self.windSpeed];
}
- (NSString *)currentVisibility
{
    return [NSString stringWithFormat:@"%.0f Miles", self.visibility];
}

        
        

@end
