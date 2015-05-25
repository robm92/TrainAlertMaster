//
//  destinationViewController.h
//  TrainAlert
//
//  Created by Rob McMorran on 11/05/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "ViewController.h"

@interface destinationViewController : ViewController
@property (weak, nonatomic) IBOutlet UITableView *lstDestination;

-(void) setUserStation:(Station*) station;


@end
