//
//  InterfaceController.m
//  TrainAlert WatchKit Extension
//
//  Created by Rob McMorran on 12/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
{
    NSString* container;
    NSUserDefaults* defaults;
}

@end


@implementation InterfaceController
@synthesize lblPlatform,lblStatus,lblReference;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    container = @"group.com.Rob.TrainAlert";
    defaults = [[NSUserDefaults alloc] initWithSuiteName:container];
    
    lblPlatform.text = [defaults valueForKey:@"Platform"];
    [self.timer setDate:[defaults valueForKey:@"DepartureTime"]];
    [self.timer start];
    lblStatus.text = [defaults valueForKey:@"Status"];
    lblReference.text = [defaults valueForKey:@"Reference"];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    lblPlatform.text = [defaults valueForKey:@"Platform"];
    [self.timer setDate:[defaults valueForKey:@"DepartureTime"]];
    [self.timer start];
    lblStatus.text = [defaults valueForKey:@"Status"];
    lblReference.text = [defaults valueForKey:@"Reference"];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


@end



