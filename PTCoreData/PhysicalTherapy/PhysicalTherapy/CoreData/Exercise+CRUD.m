//
//  Exercise+CRUD.m
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "Exercise+CRUD.h"
#import "Record.h"
#import "Record+CRUD.h"
#import "EpicCommand.h"
#import "Patient.h"
#import "HTTRequest.h"
#import "ExerciseRecordsResponse.h"



@implementation Exercise (CRUD)

+(Exercise *) exercisefromExerciseModel:(PTExerciseModel *)exerciseModel inManagedObjectContext:(NSManagedObjectContext *)context
{
    Exercise *exercise= nil;
    exercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise"
                                            inManagedObjectContext:context];
    exercise.name = exerciseModel.name;
    exercise.frequency = exerciseModel.frequency;
    exercise.link = exerciseModel.link;
    exercise.equipment = exerciseModel.equipment;
    exercise.level = exerciseModel.level;
    exercise.resistance = exerciseModel.resistance;
    exercise.sets    = exerciseModel.sets;
    exercise.time = exerciseModel.time;
    exercise.reps = exerciseModel.reps;
    exercise.weight = exerciseModel.weight;
    exercise.lastUpdate = [NSDate date];

    
    
    return  exercise;
}
-(void) addExerciseRecord:(PTExerciseRecordModel *)exerciseRecordModel
{
    Record *record= nil;
    record = [NSEntityDescription insertNewObjectForEntityForName:@"Record"
                                             inManagedObjectContext:self.managedObjectContext];
    record.duration = exerciseRecordModel.duration;
    record.intensity = exerciseRecordModel.intensity;
    record.timestamp = exerciseRecordModel.datetime;
    record.saveToEpic = [[NSNumber alloc] initWithBool:true];
    [self.managedObjectContext save:nil];
    record.exercise=self;
    
    // Save on server
    
    NSString *saveRecord =[[[EpicCommand alloc] initSaveRecordWithPatientID:self.patient.patientID didExercise:self.name withRecord:record] xml];
    HTTRequest *httpRequest = [[HTTRequest alloc] initWithEnvelope:saveRecord];
    [httpRequest sendRequestOnCompletion:^(NSString *result, NSError *error) {
        if(error)
        {
            record.saveToEpic =[[NSNumber alloc] initWithBool:true];
        }
        else
        {
            record.saveToEpic =[[NSNumber alloc] initWithBool:false];
            NSLog(@"%@",record.detail);
            NSLog(@"%@",record.description);
            //done
        }
    }];

    
}

-(int) exerciseRecordCount
{
    return [self activeExerciseRecordSet].count;
}

-(NSArray *)activeExerciseRecordSet
{
    NSPredicate *recordPredicate = [NSPredicate predicateWithFormat:@"deleteFromEpic != YES"];
   
    NSSet *temp  = [self.records filteredSetUsingPredicate:recordPredicate];
    NSSortDescriptor *timestampSort = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    NSArray *tempArr = [temp sortedArrayUsingDescriptors:[NSArray arrayWithObject:timestampSort]];
    return tempArr;
    
}

-(void) setExerciseRecordCount:(int)exerciseRecordCount
{
    
}



-(Record*) exerciseRecordAtIndex:(int) index
{
    
    return   [[self activeExerciseRecordSet] objectAtIndex:index];
}

-(void) deleteExerciseRecordAtIndex:(int)index
{
    //[self.managedObjectContext deleteObject:[self exerciseRecordAtIndex:index]];
    Record * delRecord =[self exerciseRecordAtIndex:index];
    delRecord.deleteFromEpic =[[NSNumber alloc] initWithBool:true];
    [self.managedObjectContext save:nil];
    //Delete from Server
    NSString *deleteRecordXML =[[[EpicCommand alloc] initDeleteRecordWithPatientID:self.patient.patientID forExercise:self.name atInstant:delRecord.timestamp] xml];
    HTTRequest *httpRequest = [[HTTRequest alloc] initWithEnvelope:deleteRecordXML];
    [httpRequest sendRequestOnCompletion:^(NSString *result, NSError *error) {
        if(error)
        {
            //Handle Error
        }
        else
        {
            [self.managedObjectContext deleteObject:delRecord];
        }
    }];

}

-(void) removeAllRecords
{
    for(Record *record in self.records)
    {
        [self.managedObjectContext deleteObject:record];
    }
    [self.managedObjectContext save:nil];
}

-(void) loadRecords
{
    NSLog(@"%@",self.lastUpdate);
    if (!self.lastUpdate || [self.lastUpdate compare:[NSDate dateWithTimeIntervalSinceNow:(-4*60*60)]] == NSOrderedAscending)
    {
        [self removeAllRecords];
        NSString *loadRecord = [[[EpicCommand alloc] initLoadRecordsWithPatientID:self.patient.patientID forExercise:self.name] xml];
        HTTRequest *httpRequest = [[HTTRequest alloc] initWithEnvelope:loadRecord];
        [httpRequest sendRequestOnCompletion:^(NSString *result, NSError *error) {
            if(error)
            {
                //Handle Error
            }
            else
            {
                ExerciseRecordsResponse *response = [[ExerciseRecordsResponse alloc] initWithXML:result];
                for(PTExerciseRecordModel *recordModel in response.records)
                {
                    [self addExerciseRecord:recordModel];
                    
                }
                self.lastUpdate = [NSDate date];
            }
        }];

        
    }
    else
    {
        return;
    }
    

    
   
    
}
@end
