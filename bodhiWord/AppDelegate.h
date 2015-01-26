//
//  AppDelegate.h
//  bodhiWord
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KitLocate/KitLocate.h>

@class LocationHandler;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic)int roleNum;

@property(nonatomic,strong)LocationHandler*handlerKL;
@end

