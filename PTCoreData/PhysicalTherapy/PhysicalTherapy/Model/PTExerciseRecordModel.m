//
//  PTExerciseRecordModel.m
//  PhysicalTherapy
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import "PTExerciseRecordModel.h"

@interface PTExerciseRecordModel()
{
    NSMutableString* currentElement;
    __weak PTExerciseModel * parentExercise;
    
}

@end





@implementation PTExerciseRecordModel

-(void) setTimeStamp:(NSString *)timeStamp
{
    self.datetime = [self stringToDate:timeStamp];
}

-(NSString *) name
{
    return @"";
}


-(NSString *) detail
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd HHmm"];
    NSString * det= [formatter stringFromDate:self.datetime];
    det = [det stringByAppendingString:[NSString stringWithFormat:@"  Duration: %@  Intensity: %@",self.duration,self.intensity] ];
    
    return det;
}

-(id) initWithExerciseModel:(PTExerciseModel *)exercise
{
    self = [super self];
    if(self)
    {
        parentExercise = exercise;
    }
    return self;
}

-(void)     parser:(NSXMLParser *)parser
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict
{
    NSLog(@"EXREC didStartElement: %@ - %@",currentElement,elementName);
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
    NSLog(@"EXREC didEndElement: %@ - %@",currentElement,elementName);
    
    NSString * property = [NSString stringWithString:currentElement];
    if ( [elementName isEqualToString:@"duration"] ) {
        self.duration = property;
    }
    else if ( [elementName isEqualToString:@"intensity"] ) {
        self.intensity =property;
    }
    else if ( [elementName isEqualToString:@"instant"] ) {
        self.datetime=[self stringToDate:property];
    }
    else if ( [elementName isEqualToString:@"record"] ) {
        [parser setDelegate:parentExercise];
    }
    [currentElement setString:@""];
    
}

-(NSDate *)stringToDate:(NSString *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"MM/dd/yyyy HHmm"];
    
    NSString *stringTime = date;
    
    NSDate *dateTime = [formatter dateFromString:stringTime];
    return dateTime;
}


@end
