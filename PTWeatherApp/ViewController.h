//
//  ViewController.h
//  PTWeatherApp
//
//  Created by Student P_06 on 04/08/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#warning Please enter API Key
#define KWeatherMapKey @"c873b53a2eca387aea77b1ed3f84b6fb"

//http://api.openweathermap.org/data/2.5/weather?lat=18.633435&lon=73.806983&appid=c873b53a2eca387aea77b1ed3f84b6fb

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 
{
    NSString *enterCityName;
}
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCountry;
@property (weak, nonatomic) IBOutlet UILabel *labelTemperature;
@property (weak, nonatomic) IBOutlet UILabel *labelMinimumTemperature;
@property (weak, nonatomic) IBOutlet UILabel *labelMaximumTemperature;
@property (weak, nonatomic) IBOutlet UILabel *labelPressure;
@property (weak, nonatomic) IBOutlet UILabel *labelHumidity;

@property (weak, nonatomic) IBOutlet UITextField *textfieldCityName;
- (IBAction)celsiusButtonTapped:(id)sender;
- (IBAction)farenheightButtonTapped:(id)sender;


@end

