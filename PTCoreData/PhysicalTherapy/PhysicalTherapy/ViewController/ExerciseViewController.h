//
//  ExerciseViewController.h
//  PhysicalTherapy
//
//  Created by Yousuf on 11/7/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTExerciseModel.h"
@class PTExerciseRecordModel;


@interface ExerciseViewController : UITableViewController
@property (weak,nonatomic) PTExerciseModel * exercise;
- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;
@end
