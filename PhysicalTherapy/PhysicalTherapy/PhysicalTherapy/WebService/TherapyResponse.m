//
//  TherapyResponse.m
//  Patient
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import "TherapyResponse.h"

@implementation TherapyResponse
{
    NSString *patientID;
}

-(id) initWithXML:(NSString *)xml forPatient:(NSString *)patient
{
    self =[super initWithXML:xml];
    if(self)
    {
        patientID =patient;
        
    }
    return self;
}

-(PTTherapyModel *) therapyModel
{
    NSString * exercises = [self.ResponseParameters objectForKey:@"exercises"];
    return  [[PTTherapyModel alloc] initWithXML:exercises forPatient:patientID];
}

@end
