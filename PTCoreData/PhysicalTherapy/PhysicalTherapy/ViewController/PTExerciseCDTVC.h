//
//  PTExerciseCDTVC.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface PTExerciseCDTVC : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSString * patientID;

@end
