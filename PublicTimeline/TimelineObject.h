//
//  TimelineObject.h
//  PublicTimeline
//
//  Created by Bharath G M on 3/19/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimelineObject : NSObject
{
    NSString *m_cImageURL;
    NSString *m_cUserName;
    NSString *m_cCreatedDate;
    NSString *m_cText;
}
@property (nonatomic,strong)    NSString *m_cImageURL;
@property (nonatomic,strong)    NSString *m_cUserName;
@property (nonatomic,strong)    NSString *m_cCreatedDate;
@property (nonatomic,strong)    NSString *m_cText;

@end
