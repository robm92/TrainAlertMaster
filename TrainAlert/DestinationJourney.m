//
//  DestinationJourney.m
//  TrainAlert
//
//  Created by Rob McMorran on 12/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "DestinationJourney.h"

@implementation DestinationJourney

@synthesize Aimed_arrival,Aimed_departure,Arrival_time,Departure_time, Arrival_estimate, Departure_estimate, Platform, Destination_name, Status;

- (id) initWithName: (NSDate *) aimed_arrival aimed_departure: (NSDate *) aimed_departure
       arrival_time: (NSDate *) arrival_time departure_time: (NSDate *) departure_time
   arrival_estimate: (NSInteger) arrival_estimate departure_estimate: (NSInteger) departure_estimate
          platform: (NSInteger) platform destination_name: (NSString *) destination_name
             status: (NSString *) status;
{
    self = [super init];
    if (self)
    {
        Aimed_arrival = aimed_arrival;
        Aimed_departure = aimed_departure;
        Arrival_time = arrival_time;
        Departure_estimate = departure_estimate;
        Arrival_estimate = arrival_estimate;
        Departure_estimate = departure_estimate;
        Platform = platform;
        Destination_name = destination_name;
        Status = status;
    }
    return self;
}

@end
