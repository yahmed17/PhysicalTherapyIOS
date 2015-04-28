//
//  PTPatientStore.m
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "PTPatientStore.h"
#import "EpicCommand.h"
#import "HTTRequest.h"
#import "TherapyResponse.h"
#import "Patient+CRUD.h"


@interface PTPatientStore()
{
    PTTherapyModel * therapyModel;
    HTTRequest * httpRequest;
    NSManagedObjectContext* managedObjectContext;
}
@property (nonatomic,strong) NSString *patientID;

@end
@implementation PTPatientStore

-(id) initWithPatientID:(NSString *)patientID forManagedContext:(NSManagedObjectContext *)context
{
    self = [super self];
    if(self)
    {
        self.patientID = patientID;
        self.modelPatient = nil;
        managedObjectContext = context;
        
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Patient"];
        request.predicate = [NSPredicate predicateWithFormat:@"patientID = %@", patientID];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || error || ([matches count] > 1)) {
            NSLog(@"initWithPatientID: executeFetchError: %@",error.description);
        } else if ([matches count]) {
            self.modelPatient = [matches firstObject];
            if ([self.modelPatient.lastUpdate compare:[NSDate dateWithTimeIntervalSinceNow:(-24*60*60)]] == NSOrderedAscending)
                 {
                    // [context deleteObject:self.modelPatient];
                   //  [context save:nil];
                    [self loadPatientTherapy];
                 }
           
        } else {
            [self loadPatientTherapy];
        }
        

        
        
    }
    return  self;

}

-(void) loadPatientTherapy
{
    NSString *envelopeText  =[[[EpicCommand alloc] initPhysicalTherapyWithPatientID:self.patientID byUser:@"27821"] xml];
    httpRequest = [[HTTRequest alloc] initWithEnvelope:envelopeText];
    //httpRequest.envelope = envelopeText;
    [httpRequest sendRequestOnCompletion:^(NSString *result, NSError *error) {
        if(error)
        {
            NSLog(@"%@",error.description);
        }
        else
        {
            [self httpRequestionCompletionHandlerforResult:result ];
            
        }
    }];

}

-(void) httpRequestionCompletionHandlerforResult:(NSString *)result
{
    
    NSLog(@"hhtpRequestCompletionHandler %@",[NSDate date]);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    NSError *error;
    NSArray *matches = [managedObjectContext executeFetchRequest:request error:&error];
    
    
  //  [context deleteObject:self.modelPatient];
    //[context save:nil];
    

    
    TherapyResponse *response = [[TherapyResponse alloc] initWithXML:result forPatient:self.patientID];
    therapyModel = response.therapyModel;
    
    if (self.modelPatient)
    {
        self.modelPatient.lastUpdate = [NSDate date];
        [self.modelPatient removeAllExercises];
        
    }
    else
    {
        self.modelPatient =  [Patient patientWithID:self.patientID inManagedObjectContext:managedObjectContext];
    }
    [self.modelPatient addExercisesfromExerciseModelArray:therapyModel.exercises];
    error=nil;
    if (![managedObjectContext save:&error])
          NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    request = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    error=nil;
    matches = [managedObjectContext executeFetchRequest:request error:&error];
    request.predicate = [NSPredicate predicateWithFormat:@"patient == %@", self.modelPatient];
    matches = [managedObjectContext executeFetchRequest:request error:&error];
    
    
   // self.modelPatient = [Patient patientWithID:self.patientID inM];
    
}
@end
