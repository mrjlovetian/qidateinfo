//
//  RijiCell.h
//  DateInfo
//
//  Created by MRJ on 2019/3/10.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiJiModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ImageCallback)(NSInteger index);

@interface RijiCell : UITableViewCell

@property (nonatomic, strong)RiJiModel *rijiModel;
@property (nonatomic, copy)ImageCallback imageCallback;

+ (CGFloat)hetightForModel:(RiJiModel *)model;



@end

NS_ASSUME_NONNULL_END
