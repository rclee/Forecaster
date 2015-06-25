//
//  ForecastCell.h
//  Forecastering
//
//  Created by Apple on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labelCurrentCity;
@property (nonatomic, weak) IBOutlet UILabel *labelCurrentState;
@property (nonatomic, weak) IBOutlet UILabel *labelCurrentTemp;
@property (nonatomic, weak) IBOutlet UILabel *labelCurrentCondition;

@end
