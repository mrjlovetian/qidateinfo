//
//  RijiSectionView.h
//  DateInfo
//
//  Created by MRJ on 2019/3/31.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LeftCallBack)(NSInteger btnState);

@interface RijiSectionView : UIView

@property (nonatomic, assign)NSInteger btnState;
@property (nonatomic, copy)LeftCallBack lefyCallback;
@property (nonatomic, copy)NSString *titleStr;

@end

NS_ASSUME_NONNULL_END
