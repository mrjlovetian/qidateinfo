#import "RiJiModel.h"

@implementation RiJiInfo

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [RiJiModel class]};
}

@end

@implementation RiJiModel

- (CGFloat)height {
    return 0;
}

@end
