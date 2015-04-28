//
//  Patient+CRUD.m
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "Patient+CRUD.h"
#import "PTExerciseModel.h"
#import "Exercise+CRUD.h"


@implementation Patient (CRUD)
+(Patient *) patientWithID:(NSString *)patientID inManagedObjectContext:(NSManagedObjectContext *)context
{
    Patient *patient= nil;
    patient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient"
                                                 inManagedObjectContext:context];
    patient.patientID = patientID;
    patient.lastUpdate = [NSDate date];
    return  patient;
}
-(void) addExercisesfromExerciseModelArray:(NSArray *)exercises
{
    for (PTExerciseModel *exercise in exercises) {
        Exercise *coreDataExercise = [Exercise exercisefromExerciseModel:exercise inManagedObjectContext:self.managedObjectContext];
        [self addExercisesObject:coreDataExercise];
        
    }
}

-(void) removeAllExercises
{
    
    for(Exercise *exercise in self.exercises)
    {
        [self.managedObjectContext deleteObject:exercise];
    }
    [self.managedObjectContext save:nil];
    
}
@end
