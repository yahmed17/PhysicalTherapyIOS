//
//  Exercise.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/9/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient, Record;

@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * equipment;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * level;
@property (nonatomic, retain) NSString * resistance;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * reps;
@property (nonatomic, retain) NSString * sets;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * frequency;
@property (nonatomic, retain) NSDate * lastUpdate;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) NSSet *records;
@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)addRecordsObject:(Record *)value;
- (void)removeRecordsObject:(Record *)value;
- (void)addRecords:(NSSet *)values;
- (void)removeRecords:(NSSet *)values;

@end
