//
//  CommandExecuteParameter.m
//  WebService
//
//  Created by Yousuf on 10/9/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import "CommandExecuteParameter.h"

@interface CommandExecuteParameter()

@end

@implementation CommandExecuteParameter

-(id) initWithName:(NSString *)name Value:(NSString *)value Type:(NSString *)type
{
    self = [super self];
    if(self)
    {
        _name = name;
        _type = type;
        _value = value;
    }
    return self;
}

-(NSString *) xml
{
    NSString *xml =[NSString stringWithFormat:@"<Parameter>\n"
                                                "<Name>%@</Name>\n"
                                                "<Values>\n"
                                                "<Value xsi:type=\"%@\">%@</Value>\n"
                                                "</Values>\n"
                                                "</Parameter>\n",self.name,self.type,self.value];
                    
    return xml;
}
@end
