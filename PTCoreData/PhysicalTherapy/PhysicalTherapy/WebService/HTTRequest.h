//
//  HTTRequest.h
//  WebService
//
//  Created by Yousuf on 10/9/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^RequestCompletionHandler)(NSString *,NSError *);

@interface HTTRequest : NSObject
-(id) initWithEnvelope:(NSString *) envelope;
//-(void) sendRequestReceivedBy:(id)aReceiver action:(SEL)receiverAction;
@property (nonatomic) NSString * envelope;
-(void) sendRequestOnCompletion:(RequestCompletionHandler)complete;
//-(void) finishSession;
@end
