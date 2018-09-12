//
//  UIClockView.h
//  CWC
//
//  Created by lxzh on 2017/12/3.
//  Copyright © 2017年 lxzh. All rights reserved.
//

#ifndef UIClockView_h
#define UIClockView_h
#import <UIKit/UIKit.h>


@interface UIClockView : UIView

@property (nonatomic,assign) NSInteger tHour;
@property (nonatomic,assign) NSInteger tMinute;
@property (nonatomic,assign) NSInteger tSecond;
@property (nonatomic,assign) int hourStep;

-(void)setTimeWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

-(void)setHourStep:(int)step;

@end

#endif /* UIClockView_h */
