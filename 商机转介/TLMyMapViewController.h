//
//  TLMyMapViewController.h
//  商机转介
//
//  Created by yyb on 14-10-28.
//  Copyright (c) 2014年 allinpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "CNPPopupController.h"
@class Position;
@interface TLMyMapViewController : UIViewController
@property (strong,nonatomic)IBOutlet BMKMapView* mapView;
@property (strong,nonatomic)BMKLocationService* locService;
@property (assign,nonatomic) CLLocationCoordinate2D currentSelectCoordinate;
@property (assign,nonatomic)BOOL isSetMapSpan;

//popView

- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate;
-(IBAction)setAnnotation:(id)sender;
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle andPosition:(Position *)pos;
@end

