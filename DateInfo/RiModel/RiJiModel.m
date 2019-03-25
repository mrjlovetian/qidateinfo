#import "RiJiModel.h"

@implementation RiJiModel

- (CGFloat)height {
    return 0;
}

@end

@implementation RiJiDay

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [RiJiModel class]};
}

@end

@implementation RiJiMonth

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [RiJiDay class]};
}

@end

@implementation RiJiYear
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [RiJiMonth class]};
}

@end
