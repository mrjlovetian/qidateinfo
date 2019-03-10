
#import <Foundation/Foundation.h>

@class RiJiModel;

@interface RiJiInfo : NSObject

@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSArray<RiJiModel *> *datas;

@end


@interface RiJiModel : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *dateTime;
@property (nonatomic, copy)NSString *index;
@property (nonatomic, copy)NSArray *images;
@property (nonatomic, copy)NSArray *videos;
@property (nonatomic, copy)NSArray *voices;

@property (nonatomic, assign)CGFloat height;

@end
