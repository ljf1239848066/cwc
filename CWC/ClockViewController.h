//
//  ClockViewController.h
//  CWC
//
//  Created by lxzh on 2017/12/3.
//  Copyright © 2017年 lxzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIClockView.h"

@interface ClockViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIClockView *clockView;
@property (weak, nonatomic) IBOutlet UIClockView *clockViewLittle;

@end

