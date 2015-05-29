//
//  GlanceController.m
//  TrainAlert WatchKit Extension
//
//  Created by Rob McMorran on 12/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()
{
    NSString* container;
    NSUserDefaults* defaults;
}

@end


@implementation GlanceController
@synthesize lblPlatform,lblPlatformTitle,lblSubTitle,timer,lblStatus;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.

    container = @"group.com.Rob.TrainAlert";
    defaults = [[NSUserDefaults alloc] initWithSuiteName:container];
    [self.timer setDate:[defaults valueForKey:@"DepartureTime"]];
    lblPlatform.text = [defaults valueForKey:@"Platform"];
    lblStatus.text = [defaults valueForKey:@"Status"];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [self.timer setDate:[defaults valueForKey:@"DepartureTime"]];
    [self.timer start];
    lblPlatform.text = [defaults valueForKey:@"Platform"];
    lblStatus.text = [defaults valueForKey:@"Status"];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



