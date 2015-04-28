//
//  CommandExecuteRequest.h
//  WebService
//
//  Created by Yousuf on 10/9/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandExecuteRequest : NSObject
@property (nonatomic) NSString  * ConnectionFunctionalType;
@property (nonatomic) NSString  * CommandName;
@property (nonatomic) NSMutableArray   * Parameters;
@property (nonatomic) NSString  * UserID;
-(NSString *) xml;
@end
