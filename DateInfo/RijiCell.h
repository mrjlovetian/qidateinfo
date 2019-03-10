//
//  RijiCell.h
//  DateInfo
//
//  Created by MRJ on 2019/3/10.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiModel/RiJiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RijiCell : UITableViewCell

@property (nonatomic, strong)RiJiModel *rijiModel;

+ (CGFloat)hetightForModel:(RiJiModel *)model;

@end

NS_ASSUME_NONNULL_END
