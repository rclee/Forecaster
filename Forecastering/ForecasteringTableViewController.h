//
//  ForecasteringTableViewController.h
//  Forecastering
//
//  Created by Apple on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@protocol ForecasteringTableViewControllerDelegate

- (void)cityWasFound:(City *)aCity;
- (void)weatherWasFoundForCity:(City *)aCity;

@end

@interface ForecasteringTableViewController : UITableViewController

-(void)saveCityData;


@end
