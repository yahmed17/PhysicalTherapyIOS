//
//  ExerciseRecordsResponse.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 12/12/13.
//  Copyright (c) 2013 Atrius Health. All rights reserved.
//

#import "CommandExecuteResponse.h"
#import "PTExerciseModel.h"

@interface ExerciseRecordsResponse : NSObject   <NSXMLParserDelegate>
-(id) initWithXML:(NSString *)xml forExercise:(PTExerciseModel *) exercise;
-(id) initWithXML:(NSString *)xml;
@property (nonatomic,strong,readonly) NSArray *records;
@end
