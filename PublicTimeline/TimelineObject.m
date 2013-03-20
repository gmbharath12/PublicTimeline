//
//  TimelineObject.m
//  PublicTimeline
//
//  Created by Bharath G M on 3/19/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import "TimelineObject.h"

@implementation TimelineObject
@synthesize m_cCreatedDate,m_cImageURL,m_cText,m_cUserName;

- (id)init
{
    self = [super init];
    if (self)
    {
        m_cUserName = nil;
        m_cText = nil;
        m_cImageURL = nil;
        m_cCreatedDate = nil;
    }
    return self;
}
@end
