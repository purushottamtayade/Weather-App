//
//  ViewController.m
//  PTWeatherApp
//
//  Created by Student P_06 on 04/08/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#define KFarenheightUnit @"imperial"
#define KCelsiusUnit @"metric"

#import "ViewController.h"

typedef enum : NSUInteger{
    Farenheight = 1,
    Celsius = 0,
}UnitType;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)downloadWeatherDataWithCityName:(NSString *)cityName andUnit:(UnitType)unit{
    NSString *urlString;
    
    switch(unit)
    {
            case Celsius:
            urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=metric",cityName,KWeatherMapKey];
            break;
            
        case Farenheight:
            urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=imerial",cityName,KWeatherMapKey];
            break;
            
    }
            
            NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            NSURLSessionDataTask *dataTask = [urlSession dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(error)
                {
                    NSLog(@"Error : %@",error.localizedDescription);
                }
                else{
                    if(response)
                    {
                        //DownCasting or TypeCasting of response object in to NSHTTPResponse
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                        if(httpResponse.statusCode == 200){
                            if(data){
                                NSError *error;
                                //real parsing started
                                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                if(error){
                                    NSLog(@"JSON Parsing error:%@",error.localizedDescription);
                                }
                                else {
                                    [self performSelectorOnMainThread:@selector(updateUIForCity:) withObject:jsonResponse waitUntilDone:NO];
                                }
                            }
                            else{
                                NSLog(@"Data nil.");
                            }
                        }
                        else {
                            NSLog(@"HTTP status Code : %ld",(long)httpResponse.statusCode);
                        }
                    }
                    else {
                        NSLog(@"Response Nil");
                    }
                }
            }];
            [dataTask resume];

            
    
}

-(void)updateUIForCity:(NSDictionary *)dictionary {
    
    
    NSString *name = [dictionary valueForKeyPath:@"name"];
    NSString *country = [dictionary valueForKeyPath:@"sys.country"];
    
   
    
    NSString *temperature = [NSString stringWithFormat:@"%@",[dictionary valueForKeyPath:@"main.temp"]];
    
    NSString *minimumTemperature = [NSString stringWithFormat:@"%@",[dictionary valueForKeyPath:@"main.temp_min"]];
    
    
    NSString *maximumTemperature = [NSString stringWithFormat:@"%@",[dictionary valueForKeyPath:@"main.temp_max"]];
    
    
    NSString *pressure = [NSString stringWithFormat:@"%@",[dictionary valueForKeyPath:@"main.pressure"]];
    NSString *humidity = [NSString stringWithFormat:@"%@",[dictionary valueForKeyPath:@"main.humidity"]];
    self.labelName.text = name;
    self.labelCountry.text = country;
    self.labelTemperature.text = temperature;
    self.labelMinimumTemperature.text = minimumTemperature;
    self.labelMaximumTemperature.text = maximumTemperature;
    self.labelPressure.text = pressure;
    self.labelHumidity.text = humidity;

    
}

//-(void)textViewDidBeginEditing:(UITextView *)textView{
//    textView.text = @"Please enter vallid string";
//  
//        [textView becomeFirstResponder];
//}
//
//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//    if([textView.text isEqualToString:@""])
//    {
//        textView.text = @"Enter City Name";
//    }
//    [textView resignFirstResponder];
//}








- (IBAction)celsiusButtonTapped:(id)sender {
    enterCityName = self.textfieldCityName.text;
    
    if(!([enterCityName isEqualToString:@""]))
    {
        [self.textfieldCityName resignFirstResponder];
        [self downloadWeatherDataWithCityName:enterCityName andUnit:Celsius];
        
    }
    else{
        
        self.textfieldCityName.text = @"Please enter vallid string";
        // NSLog(@"Please enter vallid string");
    }

}

- (IBAction)farenheightButtonTapped:(id)sender {
    enterCityName = self.textfieldCityName.text;
    
    if(!([enterCityName isEqualToString:@""]))
    {
        [self.textfieldCityName resignFirstResponder];
        [self downloadWeatherDataWithCityName:enterCityName andUnit:Farenheight];
        
    }
    else{
        
        self.textfieldCityName.text = @"Please enter vallid string";
        // NSLog(@"Please enter vallid string");
    }

}
@end
