//
//  VideoViewController.m
//  PhysicalTherapy
//
//  Created by Yousuf on 12/9/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import "VideoViewController.h"


@interface VideoViewController ()
{
    NSURL *videoURL;
}
@property (weak, nonatomic) IBOutlet UILabel *videoLinkLabel;

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation VideoViewController
- (IBAction)playVideo:(UIButton *)sender {
    
   self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
    self.moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer setFullscreen:YES animated:YES];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self movieLink:self.videoLink];
    [self.webView setDelegate:self];
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:videoURL];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
    
	// Do any additional setup after loading the view.
    
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"DoneLoad");
}

-(void) webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"Started");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) movieLink:(NSString *)name
{
    NSString *nameForLink = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *link;
    
    link = [@"http://www.google.com/#q=" stringByAppendingString:[name stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    link = [link stringByAppendingString:@"&undefined=undefined"];
    link = [[NSString alloc] initWithFormat:@"https://www.google.com/search?q=%@", [name stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    
    if ([nameForLink isEqualToString:@"Ell"])
    {
        link = @"http://trailers.apple.com/movies/paramount/anchorman2/anchorman2-tlr3_h720p.mov";
    }
    else if([nameForLink  isEqualToString:@"Fit"])
    {
        link=  @"http://trailers.apple.com/trailers/independent/adventuresofthepenguinking/#videos-large";
        link=@"http://trailers.apple.com/movies/fox/nightatthemuseum2/nightatthemuseum2-tlro_h480p.mov";
    }
    else
    {
        //link = @"";
    }
    videoURL =[NSURL URLWithString:link];

}

@end
