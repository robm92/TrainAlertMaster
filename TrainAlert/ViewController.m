//
//  ViewController.m
//  TrainAlert
//
//  Created by Rob McMorran on 09/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "ViewController.h"
#import "Station.h"
#import <CoreLocation/CoreLocation.h>
#import "destinationViewController.h"

@interface ViewController ()
{
    NSMutableArray * stationArray;
    DestinationJourney * dest;
    CLLocationManager *locationManager;
    NSString *userLong;
    NSString *userLat;
}

@end

@implementation ViewController
@synthesize btnDepart,btnDestination,lblDepartureTime,lblEstimateDeparture,lblPlatform,lblSource,lblStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init array
    stationArray = [[NSMutableArray alloc] init];
    dest = [[DestinationJourney alloc] init];
    
    [self.btnDestination setTitle:@"Select Destination" forState:UIControlStateNormal];
    //round corners of button
    btnDestination.layer.cornerRadius = 10;
    btnDestination.clipsToBounds = YES;
    btnDepart.layer.cornerRadius = 10;
    btnDepart.clipsToBounds = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [self getLocation];
    
    [self getStations];
    [self printStations];
    
}

- (void)getLocation { //Called when needed
    userLat = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
    userLong = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
    if(locationManager.location.coordinate.latitude < 1)
    {
        userLat = @"50.3714";
        userLong = @"-4.1422";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setDestination:(DestinationJourney*) dj
{
    dest = dj;
    [btnDestination setTitle:dest.Destination_name forState:UIControlStateNormal];
    
    lblStatus.text = dj.Status;
    lblPlatform.text = [NSString stringWithFormat:@"%ld",(long)dj.Platform];
    lblEstimateDeparture.text = [NSString stringWithFormat:@"%ld",(long)dj.Departure_estimate];
    lblDepartureTime.text = [self dateToTime:dj.Departure_time];
    
    //pass data to app group for Watch
    NSUserDefaults *myDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.Rob.TrainAlert"];

    NSDate *ArrivalTime = dj.Arrival_time;
    [myDefaults setObject: ArrivalTime forKey:@"ArrivalTime"];
    [myDefaults setObject:[NSString stringWithFormat:@"%ld",(long)dj.Platform] forKey:@"Platform"];
    
}

-(void) getStations
{
    NSMutableDictionary *json;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://transportapi.com/v3/uk/train/stations/near.json?api_key=26b7e3f8a0782a59424f3f127bc2f023&app_id=372423e8&5D&lat=%@&lon=%@&page=1&rpp=4",userLat,userLong]]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    //getting the data
    NSData *newData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //json parse
    NSString *responseString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
    json = [NSJSONSerialization JSONObjectWithData:newData
                                           options:0
                                             error:nil];
    NSLog(@"Async JSON: %@", json);//output the json dictionary raw
    
    NSArray * responseArr = json[@"stations"];
    
    for(NSDictionary * dict in responseArr)//check serial against existing serials
    {
        Station *station = [[Station alloc] init];
        station.StationName = [dict valueForKey:@"name"];
        station.StationCode = [dict valueForKey:@"station_code"];
        station.Latitude = [[dict valueForKey:@"latitude"]longValue];
        station.Longitude = [[dict valueForKey:@"longitude"]longValue];
        station.Distance = [[dict valueForKey:@"distance"]longValue];
        
        [stationArray addObject:station];
    }
    
}

- (IBAction)unwindToHome:(UIStoryboardSegue *)unwindSegue
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectdestination"])
    {
        destinationViewController *dvc = [segue destinationViewController];
        //get first station from array - the closest station (not cool I know...)
        Station * userStation = [stationArray objectAtIndex:0];
        
        [dvc setUserStation:userStation];
    }
}

-(void) printStations
{
    
    for(Station *s in stationArray)
    {
        NSLog(@"Station: %@ ", s.StationName);
        
    }
    
    Station *station = [stationArray objectAtIndex:0];
    
    [self.btnDepart setTitle:station.StationName forState:UIControlStateNormal];
}

-(NSString *) dateToTime:(NSDate *) date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSLog(@"firstPeriodTime: %@",[dateFormat stringFromDate:date]);
    
    return [dateFormat stringFromDate:date];
}






@end
