//
//  CommandExecuteRequest.m
//  WebService
//
//  Created by Yousuf on 10/9/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import "CommandExecuteRequest.h"
#import "CommandExecuteParameter.h"

@implementation CommandExecuteRequest

-(NSString *) xml
{
    NSString *xml =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                    "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n"
                    "<soap:Body>\n"
                    "<CommandExecute xmlns=\"urn:epicsystems-com:Core.2008-04.Services\">\n"
                    "<ConnectionFunctionalType>default</ConnectionFunctionalType>\n"
                    "<CommandName>%@</CommandName>\n"
                    "<Parameters>\n%@</Parameters>\n"
                    "<UserID>%@</UserID>\n"
                    "</CommandExecute>\n"
                    "</soap:Body>\n"
                    "</soap:Envelope>\n"
                    ,self.CommandName,self.parametersXML,self.UserID ];
    return  xml;
}

-(NSString *) parametersXML
{
    NSString *xml=@"";
    
    for (CommandExecuteParameter *cep in self.Parameters) {
        xml = [xml stringByAppendingString:cep.xml];
    }
    
    return  xml;
}

-(NSMutableArray *) Parameters
{
    if (!_Parameters) _Parameters =[[NSMutableArray alloc] init];
    return _Parameters;
}
@end
