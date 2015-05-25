//
//  Station.h
//  TrainAlert
//
//  Created by Rob McMorran on 11/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property (nonatomic,strong) NSString * StationCode;
@property (nonatomic,strong) NSString * StationName;
@property (nonatomic,assign) long Longitude;
@property (nonatomic,assign) long Latitude;
@property (nonatomic,assign) long Distance;


- (id) initWithName: (NSString *) stationCode stationName: (NSString *) stationName
             longitude: (long) longitude latitude: (long) latitude distance: (long) distance;

@end
