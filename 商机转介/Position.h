//
//  position.h
//  地图地图
//
//  Created by yyb on 14-10-24.
//  Copyright (c) 2014年 yyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject
@property (retain,nonatomic) NSString *tit;
@property (assign,nonatomic) double latit;
@property (assign,nonatomic) double longit;
//@property (retain,nonatomic) NSString *companyName;
-(id)initWithTitle:(NSString *)tit andLatit:(double)la andLongit:(double)lg;
@end
