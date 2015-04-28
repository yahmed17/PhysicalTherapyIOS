//
//  PTExerciseDetailCDTVC.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/8/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Exercise.h"

@interface PTExerciseDetailCDTVC : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) Exercise *exercise;
@end
