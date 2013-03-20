//
//  AsynchronousImageDownload.m
//  PublicTimeline
//
//  Created by Bharath G M on 3/20/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import "AsynchronousImageDownload.h"
#import <QuartzCore/QuartzCore.h>

@implementation AsynchronousImageDownload

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)fetchImageFromURL:(NSString*)urlString
{
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor greenColor].CGColor;

    m_cURLConnection = nil;
    m_cData = nil;
    m_cData = [NSMutableData data];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:60.0];
    m_cURLConnection = [[NSURLConnection alloc]
                  initWithRequest:request delegate:self];

}

#pragma mark --
#pragma mark NSURLConnection Delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [m_cData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    m_cData = nil;
    m_cURLConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:m_cData];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    imageView.frame = self.bounds;
    [imageView setNeedsLayout];
    [self setNeedsDisplay];

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
