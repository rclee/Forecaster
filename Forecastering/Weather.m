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
//    NSString *humid = [NSString stringWithFormat:@"%f", self.humidity];
//    NSRange range = [humid rangeOfString:@"^0*" options:NSRegularExpressionSearch];
//    humid = [humid stringByReplacingCharactersInRange:range withString:@""];
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




//- (NSString *)currentTemperature
//{
//    NSString *currentTemp = [currently objectForKey:@"temperature"];
//    double currentTempValue = [currentTemp intValue];
//    weatherItem.temperature = currentTempValue;
    
//        NSLog(@"%g current Temp", currentTempValue);
//}
//    
//        NSDictionary *daily = [darkSkyJSON objectForKey:@"daily"];
//        NSArray *data = [daily objectForKey:@"data"];
//        
//        NSDictionary *dayOne = [data objectAtIndex:0];
//        
//        NSString *icon = [dayOne objectForKey:@"icon"];
//        weatherItem.icon = icon;
//        
//        NSString *windSpeedString = [dayOne objectForKey:@"windSpeed"];
//        double windSpeedValue = [windSpeedString intValue];
//        weatherItem.windSpeed = windSpeedValue;
//        
//        NSString *precipProbabilityString = [dayOne objectForKey:@"precipProbability"];
//        double precipProbabilityValue = [precipProbabilityString intValue];
//        weatherItem.precipProbability = precipProbabilityValue;
//        
//        NSString *dewPointString = [dayOne objectForKey:@"dewPoint"];
//        double dewPointValue = [dewPointString intValue];
//        weatherItem.dewPoint = dewPointValue;
//        
//        NSString *humidityString = [dayOne objectForKey:@"humidity"];
//        double humidityValue = [humidityString intValue];
//        weatherItem.humidity = humidityValue;

        
        
        
        
        
//        NSString *time = [dayOne objectForKey:@"time"];
//        weatherItem.time = time;
//        NSString *precipIntensity = [dayOne objectForKey:@"precipIntensity"];
//        weatherItem.objectPrecipIntensity = precipIntensity;

//        NSString *precipType = [dayOne objectForKey:@"precipType"];
//        weatherItem.objectPrecipType = precipType;
//        NSString *tempMax = [dayOne objectForKey:@"temperatureMax"];
//        weatherItem.objectTempMax = tempMax;
//        NSString *windBearing = [dayOne objectForKey:@"windBearing"];
//        weatherItem.objectWindBearing = windBearing;

//        NSString *visibilityString = [dayOne objectForKey:@"visibility"];
//        double currentTempValue = [currentTemp intValue];
//        weatherItem.objectVisibility = visibility;
        
        

@end
