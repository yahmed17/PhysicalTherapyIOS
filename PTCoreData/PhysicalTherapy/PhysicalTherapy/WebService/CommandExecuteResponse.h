//
//  CommandExecuteResponse.h
//  WebService
//
//  Created by Yousuf on 10/10/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandExecuteResponse : NSObject <NSXMLParserDelegate>
@property (nonatomic,readonly) NSDictionary* ResponseParameters;
-(id) initWithXML:(NSString *) xml;
@end
