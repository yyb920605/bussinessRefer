//
//  TLMyMapViewController.m
//  商机转介
//
//  Created by yyb on 14-10-28.
//  Copyright (c) 2014年 allinpay. All rights reserved.
//

#import "TLMyMapViewController.h"
#import "position.h"
#import "MyPositionAnnotation.h"

@implementation TLMyMapViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isSetMapSpan=NO;//初始化置判定定位的数据为no
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];    // Do any additional setup after loading the view, typically from a nib.
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置跟随的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    
}
- (IBAction)set:(id)sender {
}

-(void)setAnnotation:(id)sender{
    Position *po1=[[Position alloc]initWithTitle:@"测试一" andLatit:34.7502450000 andLongit:113.6587530000];
    Position *po2=[[Position alloc]initWithTitle:@"测试二" andLatit:34.7265140000 andLongit:113.7229280000];
    Position *po3=[[Position alloc]initWithTitle:@"测试3" andLatit:34.7102450000 andLongit:113.6787530000];
    NSMutableArray *muarray=[[NSMutableArray alloc]init];
    
    [muarray addObject:po1];
    [muarray addObject:po2];
    [muarray addObject:po3];
    
    
    for (int i=0;i<[muarray count];i++ ) {
        MyPositionAnnotation* annotation = [[MyPositionAnnotation alloc]initWithPosition:
                                            [muarray objectAtIndex:i]];
        
        
        [_mapView addAnnotation:annotation];
    };
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];

    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //    BMKCoordinateRegion region;
    //    region.center.latitude  = userLocation.location.coordinate.latitude;
    //    region.center.longitude = userLocation.location.coordinate.longitude;
    ////    region.span.latitudeDelta  = 0.2;
    ////    region.span.longitudeDelta = 0.2;
    //    if (_mapView)
    //    {
    //        _mapView.region = region;
    //        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    }
    [self setMapRegionWithCoordinate:userLocation.location.coordinate];
    NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    
    NSLog(@"location error num:%@",error);
}


- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"已进入annotationViewForBubble");
    MyPositionAnnotation *pa=view.annotation;
    if(![pa.title isEqual:@"我的位置"]){
        [self showPopupWithStyle:CNPPopupStyleCentered andPosition:pa.position];
    }
}


- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle andPosition:(Position *)pos {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSString *t=pos.tit;
    NSString *a=[NSString stringWithFormat:@"%f",pos.latit];
    NSString *d=[NSString stringWithFormat:@"%f",pos.longit];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:t attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:a attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    //UIImage *icon = [UIImage imageNamed:@"icon"];
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:d attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
    
    //    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Close me" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupController *popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne, lineTwo] buttonTitles:nil destructiveButtonTitle:nil];
    popupController.theme = [CNPPopupTheme defaultTheme];
    popupController.theme.popupStyle = popupStyle;
    popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromTop;
    popupController.theme.dismissesOppositeDirection = YES;
    popupController.delegate = self;
    [popupController presentPopupControllerAnimated:YES];
}

//传入经纬度,将baiduMapView 锁定到以当前经纬度为中心点的显示区域和合适的显示范围
- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    //bool _isSetMapSpan=NO;
    BMKCoordinateRegion region;
    if (!_isSetMapSpan)//这里用一个变量判断一下,只在第一次锁定显示区域时 设置一下显示范围 Map Region
    {
        region = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.05, 0.05));//越小地图显示越详细
        _isSetMapSpan = YES;
        [_mapView setRegion:region animated:YES];//执行设定显示范围
        _currentSelectCoordinate = coordinate;
        [_mapView setCenterCoordinate:coordinate animated:YES];//根据提供的经纬度为中心原点 以动画的形式移动到该区域
    }
    
}


//- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        BMKPointAnnotation *item = (BMKPointAnnotation *)obj;
//        if (item.coordinate.latitude == _currentSelectCoordinate.latitude && item.coordinate.longitude == _currentSelectCoordinate.longitude )
//        {
//            [_mapView selectAnnotation:obj animated:YES];//执行之后,会让地图中的标注处于弹出气泡框状态
//            *stop = YES;
//        }
//    }];
//}
@end
