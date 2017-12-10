//
//  LxzhGraphic.m
//  CWC
//
//  Created by lxzh on 2017/12/6.
//  Copyright © 2017年 lxzh. All rights reserved.
//


#import "LxzhGraphic.h"

@implementation LxzhGraphic

+(NSMutableArray*)getLineRectWithStart:(CGPoint)ptStart end:(CGPoint)ptEnd startRadiu:(CGFloat) sR endRadiu:(CGFloat) eR{
    double len=sqrt(pow(ptStart.x-ptEnd.x,2)+pow(ptStart.y-ptEnd.y, 2));
    double sink=(ptStart.y-ptEnd.y)/len; //sine
    double cosk=(ptStart.x-ptEnd.x)/len; //cosin

    CGPoint ptStartL,ptStartR,ptEndR,ptEndL;
//    ptOrigin=CGPointMake(ptStart.x-sR*sink, ptStart.y+sR*cosk);
//    ptStartL=CGPointMake(ptOrigin.x, ptOrigin.y);
//    ptStartR=CGPointMake(ptStart.x+sR*sink, ptStart.y-sR*cosk);
//    ptEndL=CGPointMake(ptEnd.x-eR*sink, ptEnd.y+eR*cosk);
//    ptEndR=CGPointMake(ptEnd.x+eR*sink, ptEnd.y-eR*cosk);
    
    ptStartL=CGPointMake(ptStart.x-sR*sink, ptStart.y+sR*cosk);
    ptStartR=CGPointMake(ptStart.x+sR*sink, ptStart.y-sR*cosk);
    ptEndL=CGPointMake(ptEnd.x-eR*sink, ptEnd.y+eR*cosk);
    ptEndR=CGPointMake(ptEnd.x+eR*sink, ptEnd.y-eR*cosk);

    NSMutableArray* ptList=[[NSMutableArray alloc] init];
    [ptList addObject:[NSValue valueWithCGPoint:ptStartL]];
    [ptList addObject:[NSValue valueWithCGPoint:ptStartR]];
    [ptList addObject:[NSValue valueWithCGPoint:ptEndR]];
    [ptList addObject:[NSValue valueWithCGPoint:ptEndL]];
    //[ptList addObject:[NSValue valueWithCGPoint:ptOrigin]];

    return ptList;
}
+(NSMutableArray*)getLineRectWithCenter:(CGPoint)ptCenter angle:(CGFloat)angle
                               startLen:(CGFloat)stLen endLen:(CGFloat) enLen
                            startRadius:(CGFloat)sR endRadiu:(CGFloat) eR{
    CGPoint ptStart,ptEnd;
    ptStart=CGPointMake(ptCenter.x+stLen*cosf(angle), ptCenter.y+stLen*sinf(angle));
    ptEnd=CGPointMake(ptCenter.x-enLen*cosf(angle), ptCenter.y-enLen*sinf(angle));
    return [self getLineRectWithStart:ptStart end:ptEnd startRadiu:sR endRadiu:eR];
}
//+(CGPoint*) getLineRectWithStart:(CGPoint)ptStart end:(CGPoint)ptEnd startRadiu:(CGFloat) sR endRadiu:(CGFloat) eR{
//    double len=sqrt(pow(ptStart.x-ptEnd.x,2)+pow(ptStart.y-ptEnd.y, 2));
//    double sink=(ptStart.y-ptEnd.y)/len; //sine
//    double cosk=(ptStart.x-ptEnd.x)/len; //cosin
//
//    CGPoint points[4];
//
//    points[0]=CGPointMake(ptStart.x-sR*sink, ptStart.y+sR*cosk);
//    //points[4]=CGPointMake(points[0].x, points[0].y);
//    points[1]=CGPointMake(ptStart.x+sR*sink, ptStart.y-sR*cosk);
//    points[2]=CGPointMake(ptEnd.x-eR*sink, ptEnd.y+eR*cosk);
//    points[3]=CGPointMake(ptEnd.x+eR*sink, ptEnd.y-eR*cosk);
//
//    return points;
//}

@end
