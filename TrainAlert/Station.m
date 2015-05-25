//
//  Station.m
//  TrainAlert
//
//  Created by Rob McMorran on 11/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "Station.h"

@implementation Station

@synthesize StationCode,StationName,Longitude,Latitude,Distance;

- (id) initWithName: (NSString *) stationCode stationName: (NSString *) stationName
          longitude: (long) longitude latitude: (long) latitude distance: (long) distance;
{
    self = [super init];
    if (self)
    {
        StationCode = stationCode;
        StationName = stationName;
        Longitude = longitude;
        Latitude = latitude;
        Distance = distance;
    }
    return self;
}

@end
