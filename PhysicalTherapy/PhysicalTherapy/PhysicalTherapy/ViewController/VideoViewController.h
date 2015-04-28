//
//  VideoViewController.h
//  PhysicalTherapy
//
//  Created by Yousuf on 12/9/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic,strong) NSString * videoLink;
@property (strong,nonatomic) MPMoviePlayerController *moviePlayer;
@end
