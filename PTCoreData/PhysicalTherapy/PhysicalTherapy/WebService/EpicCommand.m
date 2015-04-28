//
//  EpicCommand.m
//  WebService
//
//  Created by Yousuf on 10/11/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import "EpicCommand.h"
#import "CommandExecuteParameter.h"

@implementation EpicCommand
-(id) initAddIntegersWith:(int)arg1 addedTo:(int)arg2 byUser:(NSString *)userID
{
    self = [super self];
    if(self)
    {
        //Parameters
        NSString *value = [NSString stringWithFormat:@"%d",arg1];
        CommandExecuteParameter *cep = [[CommandExecuteParameter alloc] initWithName:@"int1" Value:value Type:@"xsd:int"];
        [self.Parameters addObject:cep];
        value =[NSString stringWithFormat:@"%d",arg2];
        cep =[[CommandExecuteParameter alloc] initWithName:@"int2" Value:value Type:@"xsd:int"];
        [self.Parameters addObject:cep];
        
        //Name
        self.CommandName = @"TEST.ADDINTEGERS";
        
        //ConnectionFunctionalType
        self.ConnectionFunctionalType  = @"default";
        
        //User
        self.UserID = userID;
        
        
    }
    return self;

}

-(id) initPatientDemographicsWithPatientID:(NSString *)patientID byUser:(NSString *)userID
{
    self = [super self];
    if(self)
    {
        //Parameters
        CommandExecuteParameter *cep = [[CommandExecuteParameter alloc] initWithName:@"patientID" Value:patientID Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        //Name
        self.CommandName = @"ATRIUS.GETDEMOGRAPHICS";
        
        //ConnectionFunctionalType
        self.ConnectionFunctionalType  = @"default";
        
        //User
        self.UserID = userID;
        
        
    }
    return self;


}

-(id) initPhysicalTherapyWithPatientID:(NSString *)patientID byUser:(NSString *)userID
{
    self = [super self];
    if(self)
    {
        //Parameters
        CommandExecuteParameter *cep = [[CommandExecuteParameter alloc] initWithName:@"patientID" Value:patientID Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        //Name
        self.CommandName = @"TEST.GETTHERAPYS";
        
        //ConnectionFunctionalType
        self.ConnectionFunctionalType  = @"default";
        
        //User
        self.UserID = userID;
        
        
    }
    return self;

}

-(id) initSaveRecordWithPatientID:(NSString *)patientID
                      didExercise:(NSString *)name
                       withRecord:(Record *)record
{
    self = [super self];
    if(self)
    {
        //Parameters
        CommandExecuteParameter *cep = [[CommandExecuteParameter alloc] initWithName:@"patientID" Value:patientID Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        cep = [[CommandExecuteParameter alloc] initWithName:@"exercise" Value:name Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yyyy HHmm"];
        NSString * timeStamp= [formatter stringFromDate:record.timestamp];
        cep = [[CommandExecuteParameter alloc] initWithName:@"instant" Value:timeStamp Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        cep = [[CommandExecuteParameter alloc] initWithName:@"duration" Value:record.duration Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        cep = [[CommandExecuteParameter alloc] initWithName:@"score" Value:record.intensity Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        //Name
        self.CommandName = @"ATRIUS.SAVEEXERCISERECORD";
        
        //ConnectionFunctionalType
        self.ConnectionFunctionalType  = @"default";
        
        //User
        self.UserID = @"27821";
        
        
    }
    return self;
}

-(id) initLoadRecordsWithPatientID:(NSString *)patientID forExercise:(NSString *)name
{
    self = [super self];
    if(self)
    {
        //Parameters
        CommandExecuteParameter *cep = [[CommandExecuteParameter alloc] initWithName:@"patientID" Value:patientID Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        cep = [[CommandExecuteParameter alloc] initWithName:@"exercise" Value:name Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        //Name
        self.CommandName = @"ATRIUS.GETEXERCISERECORD";
        
        //ConnectionFunctionalType
        self.ConnectionFunctionalType  = @"default";
        
        //User
        self.UserID = @"27821";
        
        
    }
    return self;

}

-(id) initDeleteRecordWithPatientID:(NSString *)patientID forExercise:(NSString *)name atInstant:(NSDate *)instant
{
    self = [super self];
    if(self)
    {
        //Parameters
        CommandExecuteParameter *cep = [[CommandExecuteParameter alloc] initWithName:@"patientID" Value:patientID Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        cep = [[CommandExecuteParameter alloc] initWithName:@"exercise" Value:name Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yyyy HHmm"];
        NSString * timeStamp= [formatter stringFromDate:instant];
        cep = [[CommandExecuteParameter alloc] initWithName:@"instant" Value:timeStamp Type:@"xsd:string"];
        [self.Parameters addObject:cep];
        //Name
        self.CommandName = @"ATRIUS.DELETEEXERCISERECORD";
        
        //ConnectionFunctionalType
        self.ConnectionFunctionalType  = @"default";
        
        //User
        self.UserID = @"27821";
        
        
    }
    return self;

}


@end
