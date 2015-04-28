//
//  TherapyResponse.h
//  Patient
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import "CommandExecuteResponse.h"
#import "PTTherapyModel.h"

@interface TherapyResponse : CommandExecuteResponse
-(id) initWithXML:(NSString *)xml forPatient:(NSString *) patientID;
@property (strong,nonatomic,readonly) PTTherapyModel * therapyModel;
@end
