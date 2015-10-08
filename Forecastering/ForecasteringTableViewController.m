//
//  ForecasteringTableViewController.m
//  Forecastering
//
//  Created by Apple on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ForecasteringTableViewController.h"
#import "ForecastModalViewController.h"
#import "CityWeatherViewController.h"

#import "City.h"
#import "Weather.h"

#import "ForecastCell.h"
#import "NetworkManager.h"


#define kCitiesKey @"cities"


@interface ForecasteringTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *locationArray;
}

@end

@implementation ForecasteringTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCityData]; //see if there is any data to be loaded and load it
    
    if ([locationArray count] > 0)
    {
        for (City *aCity in locationArray)
        {
            aCity.currentWeather = [[Weather alloc] init];
        }
        [[NetworkManager sharedNetworkManager] fetchCurrentWeatherForCities:locationArray];
    }
    
    self.title = @"Add a location";
    
    [NetworkManager sharedNetworkManager].delegate = self;
}

-(void)loadCityData
{
    NSData *cityData = [[NSUserDefaults standardUserDefaults] objectForKey:kCitiesKey];
    if (cityData)
    {
        locationArray = [NSKeyedUnarchiver unarchiveObjectWithData:cityData];
    }
    else
    {
        locationArray = [[NSMutableArray alloc] init];
    }
}

-(void)saveCityData
{
    NSData *cityData = [NSKeyedArchiver archivedDataWithRootObject:locationArray];
    [[NSUserDefaults standardUserDefaults] setObject:cityData forKey:kCitiesKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return locationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastedCell" forIndexPath:indexPath];
    
    City *items = locationArray[indexPath.row];
    
    cell.labelCurrentCity.text = items.name;
    cell.labelCurrentState.text = items.state;
    cell.labelCurrentTemp.text = [items.currentWeather currentTemperature];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    City *selectedCity = locationArray[indexPath.row];
    CityWeatherViewController *cityWVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CityWeather"];
    cityWVC.aCity = selectedCity;
    
    [self.navigationController pushViewController:cityWVC animated:YES];
    
}

//- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    City *selectedCity = cities[indexPath.row];
//    weatherDetailViewController *weatherDetailVC = [self.storyboard]
//    weatherDetailVC.city = selectedCity;
//    [self]Navigation                               //RCL: Detail View
//}

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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueForecastModalView"])
    {
        UINavigationController *navController = [segue destinationViewController];
        ForecastModalViewController *forecastModalVC = [navController viewControllers][0];
        forecastModalVC.locationArray = locationArray;
    }
}

- (void)cityWasFound:(City *)aCity
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [locationArray addObject:aCity];
    aCity.currentWeather = [[Weather alloc] init];
    
    [[NetworkManager sharedNetworkManager] fetchCurrentWeatherForCity:aCity];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[locationArray indexOfObject:aCity] inSection:0];
//    ForecastCell *cell = (ForecastCell *)[self.tableView cellForRowAtIndexPath:cityPath];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)weatherWasFoundForCity:(City *)aCity
{
    NSIndexPath *cityPath = [NSIndexPath indexPathForItem:[locationArray indexOfObject:aCity] inSection:0];
    ForecastCell *cell = (ForecastCell *)[self.tableView cellForRowAtIndexPath:cityPath];
    
    cell.labelCurrentTemp.text = [aCity.currentWeather currentTemperature];
    cell.labelCurrentCondition.text = aCity.currentWeather.summary;
}


@end
