//
//  Patient+CRUD.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "Patient.h"

@interface Patient (CRUD)
+(Patient *)patientWithID:(NSString *)patientID inManagedObjectContext:(NSManagedObjectContext *)context;
-(void) addExercisesfromExerciseModelArray:(NSArray *)exercises;
-(void) removeAllExercises;
@end
