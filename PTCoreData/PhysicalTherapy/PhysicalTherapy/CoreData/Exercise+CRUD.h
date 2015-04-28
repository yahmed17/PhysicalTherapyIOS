//
//  Exercise+CRUD.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//


#import "Exercise.h"
#import "PTExerciseModel.h"

@interface Exercise (CRUD)
+(Exercise *) exercisefromExerciseModel:(PTExerciseModel *) exerciseModel inManagedObjectContext:(NSManagedObjectContext *)context;
-(void) addExerciseRecord:(PTExerciseRecordModel *)exerciseRecordModel;
@property (nonatomic) int exerciseRecordCount;
-(Record*) exerciseRecordAtIndex:(int) index;
-(void) deleteExerciseRecordAtIndex:(int) index;
-(void) loadRecords;

@end
