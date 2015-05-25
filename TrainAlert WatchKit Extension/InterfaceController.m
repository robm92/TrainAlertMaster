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
    
}

@end


@implementation InterfaceController
@synthesize lblPlatform;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    NSString* container = @"group.com.Rob.TrainAlert";
    NSUserDefaults* defaults = [[NSUserDefaults alloc] initWithSuiteName:container];
    
    lblPlatform.text = [defaults valueForKey:@"Platform"];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)btnUpdate {
    
    NSString* container = @"group.com.Rob.TrainAlert";
    NSUserDefaults* defaults = [[NSUserDefaults alloc] initWithSuiteName:container];

    lblPlatform.text = [defaults valueForKey:@"Platform"];
}
@end



