//
//  PTExerciseRecordModel.h
//  PhysicalTherapy
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PTExerciseModel;

@interface PTExerciseRecordModel : NSObject <NSXMLParserDelegate>
-(id) initWithExerciseModel:(PTExerciseModel *)exercise;
@property (nonatomic,strong) NSString *duration;
@property (nonatomic,strong) NSString *intensity;
@property (nonatomic,strong) NSString *timeStamp;
@property (nonatomic,strong) NSDate * datetime;
@property (nonatomic,strong,readonly) NSString * name;
@property (nonatomic,strong,readonly) NSString * detail;
@end
