//
//  FeedBackManager.m
//  StockScreener
//
//  Created by wangxiang on 2020/3/25.
//  Copyright © 2020 10jqka. All rights reserved.
//

#import "FeedBackManager.h"
#import <YWFeedbackFMWK/YWFeedbackKit.h>
#import <YWFeedbackFMWK/YWFeedbackViewController.h>

@interface FeedBackManager ()
@property (nonatomic, strong)YWFeedbackKit *yiJianView;
@end

@implementation FeedBackManager

+ (instancetype)oneInstance {
    
    static id _oneInstance = nil;
    static dispatch_once_t onlyToken;
    dispatch_once(&onlyToken, ^{
        _oneInstance = [[self alloc] init];
    });
    
    return _oneInstance;
}

- (YWFeedbackKit *)yiJianView {
    
    if (!_yiJianView) {
        _yiJianView = [[YWFeedbackKit alloc] initWithAppKey:@"31405521" appSecret:@"7754780d2e8c63f3d5dc920de7397f91"];
    }
    return _yiJianView;
}

- (void)jumpYiJianVC:(void (^)(UIViewController * _Nullable, NSError * _Nullable))block {
    if (block) {
        self.yiJianView.extInfo = @{@"time":[[NSDate date] description]};
        
        [self.yiJianView makeFeedbackViewControllerWithCompletionBlock:^(BCFeedbackViewController *viewController, NSError *error) {
            if (!viewController) {
                block(nil, error);
            }else{
                UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:viewController];
                block(navigationVC, nil);
                
                [viewController setCloseBlock:^(BCFeedbackViewController *feedbackController) {
                    [feedbackController dismissViewControllerAnimated:YES completion:nil];
                }];
            }
        }];
    }else{
        return;
    }
    
}

@end
