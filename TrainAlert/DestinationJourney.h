//
//  DestinationJourney.h
//  TrainAlert
//
//  Created by Rob McMorran on 12/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationJourney : NSObject

@property (nonatomic,strong) NSDate * Aimed_arrival;
@property (nonatomic,strong) NSDate * Aimed_departure;
@property (nonatomic,strong) NSDate * Arrival_time;
@property (nonatomic,strong) NSDate * Departure_time;
@property (nonatomic,assign) NSInteger Arrival_estimate;
@property (nonatomic,assign) NSInteger Departure_estimate;
@property (nonatomic,assign) NSInteger Platform;
@property (nonatomic,strong) NSString * Destination_name;
@property (nonatomic,strong) NSString * Status;

- (id) initWithName: (NSDate *) aimed_arrival aimed_departure: (NSDate *) aimed_departure
          arrival_time: (NSDate *) arrival_time departure_time: (NSDate *) departure_time
            arrival_estimate: (NSInteger) arrival_estimate departure_estimate: (NSInteger) departure_estimate
        platform: (NSInteger) platform destination_name: (NSString *) destination_name
            status: (NSString *) status;

@end
