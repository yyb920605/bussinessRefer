//
//  position.m
//  地图地图
//
//  Created by yyb on 14-10-24.
//  Copyright (c) 2014年 yyb. All rights reserved.
//

#import "Position.h"

@implementation Position
-(id)initWithTitle:(NSString *)tit andLatit:(double)la andLongit:(double)lg{
    
    self=[super init];
    self.tit=tit;
    self.latit=la;
    self.longit=lg;
    return self;

}
@end
