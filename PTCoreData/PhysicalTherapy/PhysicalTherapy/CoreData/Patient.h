//
//  Patient.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/8/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Patient : NSManagedObject

@property (nonatomic, retain) NSDate * lastUpdate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * patientID;
@property (nonatomic, retain) NSSet *exercises;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addExercisesObject:(Exercise *)value;
- (void)removeExercisesObject:(Exercise *)value;
- (void)addExercises:(NSSet *)values;
- (void)removeExercises:(NSSet *)values;

@end
