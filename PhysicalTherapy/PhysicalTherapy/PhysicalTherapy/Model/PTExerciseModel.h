//
//  PTExerciseModel.h
//  PhysicalTherapy
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTExerciseRecordModel.h"

@class  PTTherapyModel;

@interface PTExerciseModel : NSObject <NSXMLParserDelegate>



-(id) initWithTherapyModel:(PTTherapyModel *) therapy forPatient:(NSString *) patientID;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * equipment;
@property (nonatomic,strong) NSString * link;
@property (nonatomic,strong) NSString * level;
@property (nonatomic,strong) NSString * resistance;
@property (nonatomic,strong) NSString * time;
@property (nonatomic,strong) NSString * reps;
@property (nonatomic,strong) NSString * sets;
@property (nonatomic,strong) NSString * weight;
@property (nonatomic,strong) NSString * frequency;
@property (nonatomic,strong) NSArray * exerciseRecord;
@property (nonatomic) bool updateView;
@property (nonatomic,strong) NSArray * exerciseRecords;
@property (nonatomic) int exerciseRecordCount;
-(PTExerciseRecordModel *) exerciseRecordAtIndex:(int) index;
-(void) addExerciseRecord:(PTExerciseRecordModel *)exerciseRecord;
-(void) deleteExerciseRecordAtIndex:(int) index;
-(void) loadExerciseRecord;




@end
