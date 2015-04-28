//
//  CommandExecuteResponse.m
//  WebService
//
//  Created by Yousuf on 10/10/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import "CommandExecuteResponse.h"
#import "CommandExecuteParameter.h"

@interface CommandExecuteResponse()

@property (nonatomic) NSMutableString* currentElement;
@property BOOL xmlElementFound;
@property (nonatomic) CommandExecuteParameter * commandParameter;
@property (nonatomic) NSMutableDictionary  * responseParameters;
@end


@implementation CommandExecuteResponse

-(id) initWithXML:(NSString *)xml
{
    self = [super self];
    if(self)
    {
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


-(NSDictionary *) ResponseParameters
{
    
    return  self.responseParameters;
}

-(NSDictionary *) responseParameters
{
    if(!_responseParameters) _responseParameters = [[NSMutableDictionary alloc] init];
    return _responseParameters;
}

-(NSMutableString *) currentElement
{
    
    if(!_currentElement) _currentElement =[[NSMutableString alloc] init];
    return _currentElement;
}


-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Error Parse:%@",[parseError localizedDescription]);
}

//---when the start of an element is found---
-(void) parser:(NSXMLParser *) parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *) namespaceURI
 qualifiedName:(NSString *) qName
    attributes:(NSDictionary *)attributeDict
{
    if( [elementName isEqualToString:@"Parameter"])
    {
        self.xmlElementFound = YES;
        self.commandParameter = [[CommandExecuteParameter alloc] init];
    }
    if( [elementName isEqualToString:@"Name"])
    {
        self.xmlElementFound = YES;
    }
    if( [elementName isEqualToString:@"Value"])
    {
        self.xmlElementFound = YES;
    }
    //NSLog(@"didStartElement: %@",self.currentElement);
}


-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
    if (self.xmlElementFound)
    {
        [self.currentElement appendString: string];
    }

}

//---when the end of element is found---
-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Parameter"])
    {
        [self.responseParameters setObject:self.commandParameter.value forKey:self.commandParameter.name ];
    }
    else if( [elementName isEqualToString:@"Name"])
    {
        self.commandParameter.name = [NSString stringWithString:self.currentElement];
    }
    else if( [elementName isEqualToString:@"Value"])
    {
        self.commandParameter.value = [NSString stringWithString:self.currentElement];
    }
    //NSLog(@"didEndElement: %@",self.currentElement);
    [self.currentElement setString:@""];
    self.xmlElementFound =NO;

    
}

@end
