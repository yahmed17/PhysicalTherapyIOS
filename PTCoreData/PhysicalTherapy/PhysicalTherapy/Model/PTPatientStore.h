//
//  PTPatientStore.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface PTPatientStore : NSObject

-(id) initWithPatientID:(NSString *)patientID forManagedContext:(NSManagedObjectContext *)context;
@property (nonatomic,strong) Patient * modelPatient;

@end
