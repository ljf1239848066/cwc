//
//  ClockViewController.m
//  CWC
//
//  Created by lxzh on 2017/12/3.
//  Copyright © 2017年 lxzh. All rights reserved.
//

#import "ClockViewController.h"


@implementation ClockViewController

@synthesize clockView,clockViewLittle;

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect rect=clockView.frame;
//    rect.origin.x=0;
//    rect.origin.y=0;
//    rect.size.width=240;
//    rect.size.height=240;
//    UIImageView *imgView=[[UIImageView alloc] initWithFrame:rect];
//    [imgView setImage:[UIImage imageNamed:@"time"]];
//    [clockView addSubview:imgView];
//    [clockView sendSubviewToBack:imgView];
    // Do any additional setup after loading the view, typically from a nib.
    [clockView setHourStep:0];
    [clockViewLittle setHourStep:3];
    
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.5
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
}
- (void)handleTimer:(NSTimer *) timer {
    NSDate *dateNow=[[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps=[[NSDateComponents alloc] init];
    NSInteger unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|
    NSCalendarUnitDay|NSCalendarUnitWeekday|
    NSCalendarUnitHour|NSCalendarUnitMinute|
    NSCalendarUnitSecond;
    comps=[calendar components:unitFlags fromDate:dateNow];
    //    long weekNumber=[comps weekday];
    //    long day=[comps day];
    //    long year=[comps year];
    long hour=[comps hour];
    long minute=[comps minute];
    long second=[comps second];
    //NSLog(@"%ld:%ld:%ld",hour,minute,second);

    
//    [clockView setTimeWithHour:10 minute:10 second:30];
//
    [clockView setTimeWithHour:hour minute:minute second:second];
    [clockView setNeedsDisplay];
    
    [clockViewLittle setTimeWithHour:hour minute:minute second:second];
    [clockViewLittle setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
