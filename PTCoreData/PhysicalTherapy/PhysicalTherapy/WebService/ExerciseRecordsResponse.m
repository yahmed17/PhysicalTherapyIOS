//
//  ExerciseRecordsResponse.m
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 12/12/13.
//  Copyright (c) 2013 Atrius Health. All rights reserved.
//

#import "ExerciseRecordsResponse.h"

@implementation ExerciseRecordsResponse
{
    PTExerciseModel *exercise;
    bool xmlElementFound;
    NSMutableString* currentElement;
    PTExerciseRecordModel* currentExerciseRecord;
    NSMutableArray *exerciseRecords;
}

-(id) initWithXML:(NSString *)xml
{
    self =[super self];
    if(self)
    {
        CommandExecuteResponse *cer = [[CommandExecuteResponse alloc] initWithXML:xml];
        NSString * exercises = [cer.ResponseParameters objectForKey:@"records"];
        
        exerciseRecords = [[NSMutableArray alloc] initWithCapacity:5];
        NSData *data = [exercises dataUsingEncoding:NSUTF8StringEncoding];
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData: data];
        [xmlParser setDelegate:self];
        [xmlParser setShouldResolveExternalEntities:YES];
        [xmlParser setShouldProcessNamespaces:NO];
        [xmlParser setShouldReportNamespacePrefixes:NO];
        [xmlParser parse];
        
    }
    return self;
    
}

-(id) initWithXML:(NSString *)xml forExercise:(PTExerciseModel *)parentExercise
{
    self =[super self];
    if(self)
    {
        CommandExecuteResponse *cer = [[CommandExecuteResponse alloc] initWithXML:xml];
        NSString * exercises = [cer.ResponseParameters objectForKey:@"records"];

        
        exercise =parentExercise;
        exerciseRecords = [[NSMutableArray alloc] initWithCapacity:5];
        NSData *data = [exercises dataUsingEncoding:NSUTF8StringEncoding];
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData: data];
        [xmlParser setDelegate:self];
        [xmlParser setShouldResolveExternalEntities:YES];
        [xmlParser setShouldProcessNamespaces:NO];
        [xmlParser setShouldReportNamespacePrefixes:NO];
        [xmlParser parse];

    }
    return self;

}

-(NSArray *) records
{
    return  exerciseRecords;
}

-(void)     parser:(NSXMLParser *)parser
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict
{
    
    if ( [elementName isEqualToString:@"record"] ) {
        xmlElementFound =true;
        NSLog(@"ExerciseRecordResponse didStartElement: %@-%@",currentElement,elementName);
        // currentPerson is an ABPerson instance variable
        currentExerciseRecord = [[PTExerciseRecordModel alloc] initWithExerciseModel:exercise];
        [exerciseRecords addObject:currentExerciseRecord];
        return;
   }
}

-(void)     parser:(NSXMLParser *)parser
   foundCharacters:(NSString *)string
{
    if (!xmlElementFound) return;
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
    if(xmlElementFound)
    {
        NSLog(@"ExerciseRecordResponse didEndElement: %@-%@",currentElement,elementName);
        NSArray * recordComponents = [currentElement componentsSeparatedByString:@"|"];
        currentExerciseRecord.duration = recordComponents[1];
        currentExerciseRecord.intensity = recordComponents[2];
        currentExerciseRecord.timeStamp = recordComponents[0];
        [currentElement setString:@""];
        xmlElementFound=false;
    }
}


@end
