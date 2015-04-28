//
//  EpicCommand.h
//  WebService
//
//  Created by Yousuf on 10/11/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import "CommandExecuteRequest.h"
#import "PTExerciseRecordModel.h"

@interface EpicCommand : CommandExecuteRequest
-(id) initAddIntegersWith:(int)arg1  addedTo: (int) arg2 byUser:(NSString*) userID;
-(id) initPatientDemographicsWithPatientID:(NSString *)patientID  byUser:(NSString*) userID;
-(id) initPhysicalTherapyWithPatientID:(NSString *)patientID byUser:(NSString *) userID;
-(id) initSaveRecordWithPatientID:(NSString *)patientID didExercise:(NSString *)name withRecord:(PTExerciseRecordModel *) record;
-(id) initLoadRecordsWithPatientID:(NSString *)patientID forExercise:(NSString *)name;
-(id) initDeleteRecordWithPatientID:(NSString *)patientID forExercise:(NSString *)name atInstant:(NSDate *)instant;
@end
