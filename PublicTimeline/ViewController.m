//
//  ViewController.m
//  PublicTimeline
//
//  Created by Bharath G M on 3/19/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "AsynchronousImageDownload.h"

static NSString *kTimelineURL = @"https://alpha-api.app.net/stream/0/posts/stream/global";
#define CELL_TAG 100
#define ROWHEIGHT 70;

@interface ViewController ()

@end

@implementation ViewController

@synthesize m_cJsonArray;
@synthesize m_cData;
@synthesize m_cTimeLineObjects;
@synthesize m_cTimeLineInformationObject;
@synthesize m_cTableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"App.Net Timeline";
    self.m_cJsonArray = [NSArray array];
    [self fetchAndParseJSONDataInTheBackground];
    
    
}

-(void)fetchAndParseJSONDataInTheBackground
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0),
                   ^{
                       self.m_cData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kTimelineURL]];
                       
                       dispatch_async(dispatch_get_main_queue(),
                                      ^{
                                          if (!m_cData)
                                          {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Internet appears to be offline" message:@"Please try again later" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
                                              [alertView show];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                                          }
                                          else
                                          {
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              id jsonObjects = [NSJSONSerialization JSONObjectWithData:self.m_cData options:NSJSONReadingMutableContainers error:nil];
                                              [self performSelector:@selector(jsonObject:) onThread:[NSThread mainThread] withObject:jsonObjects waitUntilDone:NO];
                                          }
                                      }
                                      );
                   });
}


-(void)jsonObject:(id)jsonObject
{
    NSMutableArray *lObjects = [NSMutableArray array];
//        NSLog(@"Json Objects = %@",[[jsonObject valueForKey:@"data"] valueForKey:@"user"]);
    for (id object in [[jsonObject valueForKey:@"data"] valueForKey:@"user"])
    {
        m_cTimeLineInformationObject = [[TimelineObject alloc] init];
        m_cTimeLineInformationObject.m_cImageURL = [object valueForKeyPath:@"avatar_image.url"]; 
        m_cTimeLineInformationObject.m_cUserName = [object valueForKey:@"name"];
        m_cTimeLineInformationObject.m_cText = [object valueForKey:@"text"];
        m_cTimeLineInformationObject.m_cCreatedDate = [object valueForKey:@"created_at"];
        [lObjects addObject:m_cTimeLineInformationObject];
    }
    self.m_cJsonArray = lObjects;
    
    [self initTableView];
}


-(void)initTableView
{
    m_cTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 410) style:UITableViewStylePlain];
    m_cTableView.delegate = self;
    m_cTableView.dataSource = self;
    [self.view addSubview:m_cTableView];
}


#pragma mark --
#pragma mark Table View Data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_cJsonArray count];//no of objects
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.highlighted = NO;
    }
    else
    {
        AsynchronousImageDownload *lImageView = (AsynchronousImageDownload*)[cell.contentView viewWithTag:CELL_TAG];
        [lImageView removeFromSuperview];
    }
    TimelineObject *ltimeline = [m_cJsonArray objectAtIndex:indexPath.row];
    CGRect frame = CGRectMake(5, 5, 48, 48);
	AsynchronousImageDownload* asyncImage = [[AsynchronousImageDownload alloc]
                                             initWithFrame:frame];
    asyncImage.tag = CELL_TAG;
	[asyncImage fetchImageFromURL:ltimeline.m_cImageURL];
	[cell.contentView addSubview:asyncImage];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 270, 40)];
    nameLabel.text = [NSString stringWithFormat:@"%@ at %@",ltimeline.m_cUserName,ltimeline.m_cCreatedDate];
    //I have also written a function -(NSDate*)dateFromString:(NSString*)string. This works fine but not used here coz I need to create another label.

    nameLabel.font = [UIFont boldSystemFontOfSize:14];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    [cell.contentView addSubview:nameLabel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROWHEIGHT
}


#pragma --
#pragma mark Table View Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *lDetailController = [[DetailViewController alloc] init];
    lDetailController.navigationItem.title = @"Detail";
    [self.navigationController pushViewController:lDetailController animated:YES];
}


#pragma mark --
#pragma Date from String
-(NSDate*)dateFromString:(NSString*)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSTimeZone *timezone = [NSTimeZone timeZoneWithAbbreviation:@"EDT"];
	[dateFormatter setTimeZone:timezone];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];//2013-03-20T05:46:33-0500
	NSDate *date = [dateFormatter dateFromString:string];
    NSLog(@"Date = %@",date);
    return date;
}
@end
