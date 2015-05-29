//
//  GlanceController.h
//  TrainAlert WatchKit Extension
//
//  Created by Rob McMorran on 12/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface GlanceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblPlatformTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblPlatform;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceTimer *timer;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblStatus;

@end
