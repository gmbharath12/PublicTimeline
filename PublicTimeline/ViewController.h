//
//  ViewController.h
//  PublicTimeline
//
//  Created by Bharath G M on 3/19/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineObject.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *m_cJsonArray;
    NSData *m_cData;
    NSArray *m_cTimeLineObjects;
    TimelineObject *m_cTimeLineInformationObject;
    UITableView *m_cTableView;
    id m_cGenericObject;
}
@property (nonatomic,strong)  NSArray *m_cJsonArray;
@property (nonatomic,strong)  NSData *m_cData;
@property (nonatomic,strong) NSArray *m_cTimeLineObjects;
@property (nonatomic,strong) TimelineObject *m_cTimeLineInformationObject;
@property (nonatomic,strong) UITableView *m_cTableView;

@end
