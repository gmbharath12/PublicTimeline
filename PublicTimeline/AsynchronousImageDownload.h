//
//  AsynchronousImageDownload.h
//  PublicTimeline
//
//  Created by Bharath G M on 3/20/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsynchronousImageDownload : UIView
{
    NSURLConnection *m_cURLConnection;
    NSMutableData *m_cData;
}
-(void)fetchImageFromURL:(NSString*)urlString;
@end
