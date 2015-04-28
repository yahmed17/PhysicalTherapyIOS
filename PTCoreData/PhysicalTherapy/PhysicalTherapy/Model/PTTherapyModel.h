//
//  PTTherapyModel.h
//  PhysicalTherapy
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTExerciseModel.h"


@interface PTTherapyModel : NSObject <NSXMLParserDelegate>
-(id) initWithXML:(NSString *) xml forPatient:(NSString *) patientID;
@property (nonatomic,strong) NSArray * exercises;
@property (nonatomic,strong) NSString *patientID;
@property (nonatomic) int count;
-(PTExerciseModel *) exerciseAtIndex:(int) index;
@end
