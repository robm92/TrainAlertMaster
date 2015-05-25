//
//  destinationViewController.m
//  TrainAlert
//
//  Created by Rob McMorran on 11/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "destinationViewController.h"
#import "Station.h"
#import "DestinationJourney.h"
#import "ViewController.h"

@interface destinationViewController ()
{
    NSMutableArray *destinationArray;
    NSIndexPath *destinationIndex;
    Station *userStation;
}

@end

@implementation destinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init array
    destinationArray = [[NSMutableArray alloc] init];
    
    self.lstDestination.dataSource = self;
    self.lstDestination.delegate = self;
    
    [self getDeparture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getDeparture
{
    NSMutableDictionary *json;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://transportapi.com/v3/uk/train/station/%@/live.json?api_key=26b7e3f8a0782a59424f3f127bc2f023&app_id=372423e8&limit=6",userStation.StationCode]]];
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
    
    NSArray * responseArr = [[json objectForKey:@"departures"]objectForKey:@"all"];
    
    for(NSDictionary * dict in responseArr)//check serial against existing serials
    {
        DestinationJourney * dj = [[DestinationJourney alloc] init];
        
        //if trains start at the station they will come through as <null> arrival.
        if (![[dict valueForKey:@"aimed_arrival_time"]  isEqual: (id)[NSNull null]])
        dj.Aimed_arrival = [self stringToDate:[dict valueForKey:@"aimed_arrival_time"]];
        
        dj.Aimed_departure = [self stringToDate:[dict valueForKey:@"aimed_departure_time"]];
        
        if (![[dict valueForKey:@"expected_arrival_time"]  isEqual: (id)[NSNull null]])
        dj.Arrival_time = [self stringToDate:[dict valueForKey:@"expected_arrival_time"]];
        
        dj.Departure_time= [self stringToDate:[dict valueForKey:@"expected_departure_time"]];
        
        if (![[dict valueForKey:@"best_arrival_estimate_mins"]  isEqual: (id)[NSNull null]])
        dj.Arrival_estimate = [[dict valueForKey:@"best_arrival_estimate_mins"]integerValue];
        
        dj.Departure_estimate = [[dict valueForKey:@"best_departure_estimate_mins"]integerValue];
        dj.Platform = [[dict valueForKey:@"platform"]integerValue];
        dj.Destination_name = [dict valueForKey:@"destination_name"];
        dj.Status = [dict valueForKey:@"status"];
        
        [destinationArray addObject:dj];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"unwindToHome"])
    {
        ViewController *vc = [segue destinationViewController];
        DestinationJourney *dj = [destinationArray objectAtIndex:destinationIndex.row];
        [vc setDestination:dj];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    destinationIndex = indexPath;
    [self performSegueWithIdentifier:@"unwindToHome" sender:self];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

//number rows in list
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [destinationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    DestinationJourney * dj = [destinationArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",[self dateToTime:dj.Departure_time],dj.Destination_name ];
    return cell;
}

-(NSDate *) stringToDate:(NSString *) str
{
    //takes a string time and turns it into a date - todays date with that time...
    // convert to date
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // ignore +11 and use timezone name instead of seconds from gmt
    [dateFormat setDateFormat:@"HH:mm"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    NSDate *dte = [dateFormat dateFromString:str];
    
    NSDate *today = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit ) fromDate:today];
    
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:dte];
    
    [dateComponents setHour:[timeComponents hour]];
    [dateComponents setMinute:[timeComponents minute]];
    [dateComponents setSecond:[timeComponents second]];
    
    NSDate *newDate = [calendar dateFromComponents:dateComponents]; // New Date with My "Year" "Month" "Date" "Hours" "Minutes" and "Seconds"
    
    return newDate;

}
-(NSString *) dateToTime:(NSDate *) date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSLog(@"firstPeriodTime: %@",[dateFormat stringFromDate:date]);
    
    return [dateFormat stringFromDate:date];
}

-(void) setUserStation:(Station*) station
{
    userStation = station;
}


@end
