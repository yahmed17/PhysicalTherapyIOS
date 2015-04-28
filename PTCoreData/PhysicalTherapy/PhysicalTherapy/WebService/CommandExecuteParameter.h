//
//  CommandExecuteParameter.h
//  WebService
//
//  Created by Yousuf on 10/9/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandExecuteParameter : NSObject
-(id) initWithName:(NSString *)name Value:(NSString *)value Type:(NSString *) type;
-(NSString *) xml;
@property  NSString* name;
@property  NSString* value;
@property (readonly) NSString* type;
@end
