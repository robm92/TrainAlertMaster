//
//  ViewController.h
//  TrainAlert
//
//  Created by Rob McMorran on 09/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"
#import "DestinationJourney.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnDepart;
@property (weak, nonatomic) IBOutlet UIButton *btnDestination;
@property (weak, nonatomic) IBOutlet UILabel *lblDepartureTime;
@property (weak, nonatomic) IBOutlet UILabel *lblEstimateDeparture;
@property (weak, nonatomic) IBOutlet UILabel *lblPlatform;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblSource;

-(void) setDestination:(DestinationJourney *) dj;

@end

