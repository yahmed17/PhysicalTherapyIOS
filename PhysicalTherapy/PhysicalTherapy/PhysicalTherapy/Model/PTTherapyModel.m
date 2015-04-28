//
//  PTTherapyModel.m
//  PhysicalTherapy
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import "PTTherapyModel.h"
#import "PTExerciseModel.h"

@interface PTTherapyModel()
{
    NSMutableString* currentElement;
    PTExerciseModel* currentExercise;
}
@property (strong,nonatomic)    NSMutableArray * exerciseList;
@end

@implementation PTTherapyModel

//designated initializer
-(id) initWithXML:(NSString *)xml forPatient:(NSString *)patient
{
    self = [super self];
    if(self)
    {
        self.patientID = patient;
        NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData: data];
        [xmlParser setDelegate:self];
        [xmlParser setShouldResolveExternalEntities:YES];
        [xmlParser setShouldProcessNamespaces:NO];
        [xmlParser setShouldReportNamespacePrefixes:NO];
        [xmlParser parse];
        
    }
    return  self;
}

-(int) count
{
    return  [self.exerciseList count];
}

-(PTExerciseModel *) exerciseAtIndex:(int)index
{
    if(index>self.exerciseList.count-1)
    {
        return nil;
    }
    
    return  [self.exerciseList objectAtIndex:index];
}

-(void)     parser:(NSXMLParser *)parser
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict
{
    
    if ( [elementName isEqualToString:@"exercise"] ) {
        NSLog(@"THERAPT didStartElement: %@-%@",currentElement,elementName);
        // currentPerson is an ABPerson instance variable
        currentExercise = [[PTExerciseModel alloc] initWithTherapyModel:self forPatient:self.patientID];
        [self.exerciseList addObject:currentExercise];
        [parser setDelegate:currentExercise];
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
    NSLog(@"THERAPT didEndElement: %@-%@",currentElement,elementName);
    [currentElement setString:@""];
}

-(NSMutableArray *) exerciseList
{
    if (!_exerciseList) _exerciseList = [[NSMutableArray alloc] init];
    return  _exerciseList;
}

-(NSArray *) exercises
{
    return  self.exerciseList;
}

@end
