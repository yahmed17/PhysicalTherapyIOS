//
//  HTTRequest.m
//  WebService
//
//  Created by Yousuf on 10/9/13.
//  Copyright (c) 2013 Yousuf. All rights reserved.
//

#import "HTTRequest.h"

NSString * const SITE_ADDRESS =@"https://iatriustest.atriushealth.org/Interconnect-build";
NSString * const SERVICE_CORE = @"/httplistener.ashx";

@interface HTTRequest()

@property (nonatomic) NSMutableURLRequest *request;
@property  NSMutableData *receivedData;
@property (nonatomic) id receiver;
@property (nonatomic) SEL action;
@property (nonatomic) NSURLSession * session;
@end

@implementation HTTRequest
-(id) initWithEnvelope:(NSString *)envelope
{
    self = [super self];
    if(self)
    {
        NSString *url = [SITE_ADDRESS stringByAppendingString:SERVICE_CORE];
        _envelope = envelope;
        NSData *envelopeData = [envelope dataUsingEncoding:NSUTF8StringEncoding];
        
        _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:30.0];
        [_request addValue:@"" forHTTPHeaderField:@"SOAPAction"];
        [_request setHTTPMethod:@"POST"];
        [_request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [_request setHTTPBody:envelopeData];
        [_request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[envelope length]]forHTTPHeaderField:@"Content-Length"];
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
    }
    return  self;
}

-(void) setEnvelope:(NSString *)envelope
{
    _envelope = envelope;
    if(self.request)
    {
        NSData *envelopeData = [envelope dataUsingEncoding:NSUTF8StringEncoding];
        [self.request setHTTPBody:envelopeData];
    }
}
-(void) sendRequestOnCompletion:(RequestCompletionHandler)complete
{
   
    NSURLSessionDataTask   *task = [self.session dataTaskWithRequest:self.request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  
                                                  NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                  
                                                  if(complete)
                                                  {
                                                      complete(result,error);
                                                  }
                                    }];
    [task resume];
}

//-(void) finishSession
//{
//    [self.session finishTasksAndInvalidate];
//   
//}

//-(void) sendRequestReceivedBy:(id)aReceiver action:(SEL)receiverAction
//{
//    // fire away
//    self.action = receiverAction;
//    self.receiver = aReceiver;
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
//    if (connection)
//        self.receivedData = [NSMutableData data];
//    else
//        NSLog(@"NSURLConnection initWithRequest: Failed to return a connection.");
//}


//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    [self.receivedData setLength:0];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    
//    [self.receivedData appendData:data];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"connection didFailWithError: %@ %@", error.localizedDescription,
//          [error.userInfo objectForKey:NSURLErrorFailingURLStringErrorKey]);
//}



//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    
//    NSLog(@"DONE. Received Bytes:%d",[self.receivedData length]);
//    
//    NSString *response = [[NSString alloc] initWithBytes:[self.receivedData mutableBytes] length:[self.receivedData length] encoding:NSUTF8StringEncoding];
//    
//    [self.receiver performSelector:self.action withObject:response];
//    
//}



@end
