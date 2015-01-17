//
//  JsonPostModel.h
//  bodhiWord
//
//  Created by apple on 14/12/15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack) (id obj);


@interface JsonPostModel : NSObject
+(JsonPostModel*)shareJsonPostModel;
-(void)showWaitAlertView;
-(void)dismissWaitAlertView;


-(void)requestMainviewRoleImage:(CallBack)callBack;


-(void)requestPlayViewData:(CallBack)callBack;
-(void)requestPlayViewedAppDetailWithParams:(NSString*)params and:(CallBack)callBack;

-(void)requestPlayViewSegmentRightView:(CallBack)callBack;
-(void)requestPlayViewSocialWithParams:(NSString*)params andCallBack:(CallBack)callBack;

-(void)requestWatchViewTVList:(CallBack)callBack;
-(void)requestwatchviewFilmsList:(CallBack)callBack;
-(void)requestwatchViewVideoList:(CallBack)callBack;
-(void)requestwatchViewebookList:(CallBack)callBack;

@end
