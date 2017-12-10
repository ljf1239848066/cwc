//
//  UIClockView.m
//  CWC
//
//  Created by lxzh on 2017/12/3.
//  Copyright © 2017年 lxzh. All rights reserved.
//

#import "UIClockView.h"
#import "util/LxzhGraphic.h"

@implementation UIClockView

@synthesize tHour,tMinute,tSecond;

-(void)setTimeWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    self.tHour=hour;
    self.tMinute=minute;
    self.tSecond=second;
}

-(void) drawLineWithContext:(CGContextRef)context
                     center:(CGPoint)center
                      angle:(CGFloat)angle
                   startLen:(CGFloat)stLen
                     endLen:(CGFloat)enLen
                startRadius:(CGFloat)stRadius
                  endRadius:(CGFloat)enRadius
               endClockwise:(BOOL)endClockwise
                      color:(UIColor*)color
                  lineWidth:(CGFloat)lineWidth{
    NSMutableArray *ptList=[LxzhGraphic getLineRectWithCenter:center angle:angle startLen:stLen
                                       endLen:enLen startRadius:stRadius endRadiu:enRadius];
    CGPoint points[4];
    for (int i=0; i<4; i++) {
        points[i]=[[ptList objectAtIndex:i] CGPointValue];
        //        NSLog(@"i=%d(%f,%f)",i,points[i].x,points[i].y);
    }
    CGPoint ptStart=CGPointMake((points[0].x+points[1].x)/2, (points[0].y+points[1].y)/2);
    CGPoint ptEnd=CGPointMake((points[2].x+points[3].x)/2, (points[2].y+points[3].y)/2);
    //CGContextMoveToPoint(context, points[0].x, points[0].y);
    
    double alphaa=M_PI_2+angle;
    double alphab=alphaa+M_PI;
    if(endClockwise){
        CGContextAddArc(context, ptStart.x, ptStart.y, stRadius, alphaa, alphab, 1);
        CGContextAddArc(context, ptEnd.x, ptEnd.y, enRadius, alphab, alphaa, 1);
    }else{
        CGContextAddArc(context, ptStart.x, ptStart.y, stRadius, alphaa, alphab, 1);
        CGContextAddArc(context, ptEnd.x, ptEnd.y, enRadius*1.5, alphab, alphaa, 1);
    }
    
    CGContextClosePath(context);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context,lineWidth);//线条宽度
    CGContextDrawPath(context,kCGPathFillStroke);
}

-(void)drawCircleWithContext:(CGContextRef)context
                      center:(CGPoint)center
                       radiu:(CGFloat)radiu
                       color:(UIColor*)color
                   lineWidth:(CGFloat)lineWidth
                        fill:(BOOL)filled{
    CGContextSetStrokeColorWithColor(context, color.CGColor);//笔颜色
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextSetLineWidth(context,lineWidth);//线条宽度
    //绘制圆形(中心坐标(x,y)),半径radiu，起点弧度0，重点弧度2PI，画的方向0逆、1正
    CGContextAddArc(context, center.x, center.y, radiu, 0, 2*M_PI, 1);
    CGContextDrawPath(context,filled?kCGPathFillStroke:kCGPathStroke);//渲染上下文
}

- (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    //如果系统为iOS7.0；
    CGSize labelSize = [text boundingRectWithSize: maxSize
                                          options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                       attributes:attributes
                                          context:nil].size;
//    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}

- (void)drawRect:(CGRect)rect{

    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    UIImage *img=[UIImage imageNamed:@"time"];
//    UIGraphicsPushContext(ctx);
//    [img drawInRect:rect];
//    UIGraphicsPopContext();
//    CGContextStrokePath(ctx);//渲染上下文
    
    CGFloat width=rect.size.width;
    CGFloat height=rect.size.height;
    CGFloat diameter=MIN(width, height)-8;
    CGFloat radiu=diameter/2;
    CGPoint center=CGPointMake(width/2, height/2);

    //表盘外环圆
    UIColor *color=[UIColor colorWithRed:0.2 green:0.1 blue:0.2 alpha:0.4];
    [self drawCircleWithContext:ctx center:center radiu:radiu color:color lineWidth:1 fill:NO];
    
    //表盘外环内圆
    color=[UIColor colorWithRed:0.37 green:0.37 blue:0.37 alpha:0.95];
    [self drawCircleWithContext:ctx center:center radiu:radiu*0.9 color:color lineWidth:1 fill:YES];
    
    CGFloat fontSize=radiu/6.5;
    CGSize maxSize=CGSizeMake(radiu/4, radiu/6.5);
    int step=3;
    color=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.95];
    for(int i=step;i<=12;i+=step){
        double angle=(-90+i*30.0)/180*M_PI;
        NSString *txt=[NSString stringWithFormat:@"%d",i];
        CGSize size=[self labelAutoCalculateRectWith:txt FontSize:fontSize MaxSize:maxSize];
        CGRect txtRect=CGRectMake(center.x+radiu*0.8*cos(angle)-size.width/2, center.y+radiu*0.8*sin(angle)-size.height/2, size.width, size.height);
        [txt drawInRect:txtRect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];
    }
    
    //时针
    double hourAngle=(-90+self.tHour*30.0-self.tMinute*0.5)/180*M_PI;
    color=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8];
    [self drawLineWithContext:ctx center:center angle:hourAngle startLen:(radiu*0.4) endLen:(radiu*-0.03)
                  startRadius:radiu/24.0 endRadius:radiu/24.0 endClockwise:FALSE color:color lineWidth:0.5];
    //分针
    double minuteAngle=(-90+self.tMinute*6.0)/180*M_PI;
    color=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.9];
    [self drawLineWithContext:ctx center:center angle:minuteAngle startLen:(radiu*0.5) endLen:(radiu*-0.03)
                  startRadius:radiu/24.0 endRadius:radiu/24.0 endClockwise:FALSE color:color lineWidth:0.5];
    
    //时针分针轴盖
    color=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    [self drawCircleWithContext:ctx center:center radiu:radiu/12.0 color:color lineWidth:0.5 fill:YES];
    
    //秒针
    double secondAngle=(-90+self.tSecond*6.0)/180*M_PI;
    color=[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.6];
    [self drawLineWithContext:ctx center:center angle:secondAngle startLen:(radiu*0.7) endLen:(radiu*0.15)
                  startRadius:radiu/400.0 endRadius:radiu/120.0 endClockwise:TRUE color:color lineWidth:0.5];
    //秒针盖
    color=[UIColor colorWithRed:1 green:0 blue:0 alpha:0.95];
    [self drawCircleWithContext:ctx center:center radiu:radiu/40.0 color:color lineWidth:0.5 fill:YES];
}

@end
