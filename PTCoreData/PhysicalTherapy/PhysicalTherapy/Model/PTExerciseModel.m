//
//  PTExerciseModel.m
//  PhysicalTherapy
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import "PTExerciseModel.h"
#import "EpicCommand.h"
#import "HTTRequest.h"
#import "ExerciseRecordsResponse.h"

@interface PTExerciseModel()

{
    NSMutableString* currentElement;
    __weak PTTherapyModel * parentTherapy;
    NSString *patientID;
}
@property (strong,nonatomic)    NSMutableArray * recordList;

@end

@implementation PTExerciseModel



-(id) initWithTherapyModel:(PTTherapyModel *)therapy forPatient:(NSString *)patient
{
    self = [super self];
    if(self)
    {
        parentTherapy = therapy;
        patientID = patient;
    }
    return self;
}

-(void)     parser:(NSXMLParser *)parser
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict
{
    if ( [elementName isEqualToString:@"record"] ) {
        NSLog(@"THERAPT didStartElement: %@-%@",currentElement,elementName);
        // currentPerson is an ABPerson instance variable
        PTExerciseRecordModel * record = [[PTExerciseRecordModel alloc] initWithExerciseModel:self];
        [self.recordList addObject:record];
        [parser setDelegate:record];
        return;
    }
}

-(void)     parser:(NSXMLParser *)parser
   foundCharacters:(NSString *)string
{
    if (!currentElement) {
        // currentStringValue is an NSMutableString instance variable
        currentElement = [[NSMutableString alloc] initWithCapacity:50];
    }
    [currentElement appendString:string];
}

-(void)     parser:(NSXMLParser *)parser
     didEndElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
{
    NSLog(@"EXERCISE didEndElement: %@ - %@",currentElement,elementName);
    
    NSString * property = [NSString stringWithString:currentElement];
    if ( [elementName isEqualToString:@"name"] ) {
        self.name = property;
    }
    else if ( [elementName isEqualToString:@"equipment"] ) {
        self.equipment =property;
    }
    else if ( [elementName isEqualToString:@"level"] ) {
        self.level=property;
    }
    else if ( [elementName isEqualToString:@"resistance"] ) {
        self.resistance =property;
    }
    else if ( [elementName isEqualToString:@"time"] ) {
        self.time =property;
    }
    else if ( [elementName isEqualToString:@"repetitions"] ) {
        self.reps =property;
    }
    else if ( [elementName isEqualToString:@"sets"] ) {
        self.sets =property;
    }
    else if ( [elementName isEqualToString:@"weight"] ) {
        self.weight =property;
    }
    else if ( [elementName isEqualToString:@"frequency"] ) {
        self.frequency =property;
    }
    else if ( [elementName isEqualToString:@"exercise"] ) {
        [parser setDelegate:parentTherapy];
    }
    [currentElement setString:@""];
    
}

-(NSMutableArray *) recordList
{
    if (!_recordList) _recordList = [[NSMutableArray alloc]init];
    return _recordList;
}

-(NSArray*) exerciseRecords
{
    return self.recordList;
}

-(PTExerciseRecordModel *) exerciseRecordAtIndex:(int)index
{
    if (index<self.recordList.count)
    {
        return [self.recordList objectAtIndex:index];
    }
    return nil;
}

-(int) exerciseRecordCount
{
    return self.recordList.count;
}

//-(void) addExerciseRecord:(PTExerciseRecordModel *)exerciseRecord
//{
//    [self.recordList addObject:exerciseRecord];
//    NSString *saveRecord =[[[EpicCommand alloc] initSaveRecordWithPatientID:patientID didExercise:self.name withRecord:exerciseRecord] xml];
//    HTTRequest *httpRequest = [[HTTRequest alloc] initWithEnvelope:saveRecord];
//    [httpRequest sendRequestOnCompletion:^(NSString *result, NSError *error) {
//        if(error)
//        {
//            //Handle Error
//        }
//        else
//        {
//            //done
//        }
//    }];
//
//    
//}
//
//-(void) deleteExerciseRecordAtIndex:(int)index
//{
//    PTExerciseRecordModel *delRecord = [self.recordList objectAtIndex:index];
//    NSString *deleteRecordXML =[[[EpicCommand alloc] initDeleteRecordWithPatientID:patientID forExercise:self.name atInstant:delRecord.datetime] xml];
//    HTTRequest *httpRequest = [[HTTRequest alloc] initWithEnvelope:deleteRecordXML];
//    [httpRequest sendRequestOnCompletion:^(NSString *result, NSError *error) {
//        if(error)
//        {
//            //Handle Error
//        }
//        else
//        {
//            //done
//        }
//    }];
//
//    [self.recordList removeObjectAtIndex:index];
//}

-(void) loadExerciseRecord
{
    if (_recordList !=nil) return;
    NSString *loadRecord = [[[EpicCommand alloc] initLoadRecordsWithPatientID:patientID forExercise:self.name] xml];
    HTTRequest *httpRequest = [[HTTRequest alloc] initWithEnvelope:loadRecord];
    [httpRequest sendRequestOnCompletion:^(NSString *result, NSError *error) {
        if(error)
        {
            //Handle Error
        }
        else
        {
            ExerciseRecordsResponse *response = [[ExerciseRecordsResponse alloc] initWithXML:result forExercise:self];
            [self.recordList addObjectsFromArray:response.records];
                    }
    }];

    
    
}

@end
