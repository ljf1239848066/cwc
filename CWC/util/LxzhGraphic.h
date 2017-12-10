//
//  LxzhGraphic.h
//  CWC
//
//  Created by lxzh on 2017/12/6.
//  Copyright © 2017年 lxzh. All rights reserved.
//

#ifndef LxzhGraphic_h
#define LxzhGraphic_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LxzhGraphic : NSObject

+(NSMutableArray*)getLineRectWithStart:(CGPoint)ptStart end:(CGPoint)ptEnd startRadiu:(CGFloat) sR endRadiu:(CGFloat) eR;
+(NSMutableArray*)getLineRectWithCenter:(CGPoint)ptCenter angle:(CGFloat)angle startLen:(CGFloat) stLen endLen:(CGFloat) enLen startRadius:(CGFloat)sR endRadiu:(CGFloat) eR;
//(CGPoint*)getLineRectWithStart:(CGPoint)ptStart end:(CGPoint)ptEnd startRadiu:(CGFloat) sR endRadiu:(CGFloat) eR;

@end
#endif /* LxzhGraphic_h */
