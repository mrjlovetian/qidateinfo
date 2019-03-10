//
//  RijiCell.m
//  DateInfo
//
//  Created by MRJ on 2019/3/10.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RijiCell.h"
#import <YYText/YYText.h>
#import <Masonry.h>
#import "UIView+Layout.h"
#import <UIImageView+WebCache.h>
#import "FileManager.h"

#define ImageHeight (MoreImageHeight)
#define MoreImageHeight ((ScreenSzie.width - 40)/3)

@interface RijiCell()

@property (nonatomic, strong)YYLabel *titleLab;
@property (nonatomic, strong)UILabel *contentLab;
@property (nonatomic, strong)YYLabel *dateLab;

@property (nonatomic, strong)UIImageView *imageView1;
@property (nonatomic, strong)UIImageView *imageView2;
@property (nonatomic, strong)UIImageView *imageView3;
@property (nonatomic, strong)UIImageView *imageView4;
@property (nonatomic, strong)UIImageView *imageView5;
@property (nonatomic, strong)UIImageView *imageView6;
@property (nonatomic, strong)UIImageView *imageView7;
@property (nonatomic, strong)UIImageView *imageView8;
@property (nonatomic, strong)UIImageView *imageView9;

@end

@implementation RijiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.dateLab];
    
    [self.contentView addSubview:self.imageView1];
    [self.contentView addSubview:self.imageView2];
    [self.contentView addSubview:self.imageView3];
    [self.contentView addSubview:self.imageView4];
    [self.contentView addSubview:self.imageView5];
    [self.contentView addSubview:self.imageView6];
    [self.contentView addSubview:self.imageView7];
    [self.contentView addSubview:self.imageView8];
    [self.contentView addSubview:self.imageView9];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).mas_offset(10);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(10);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)hetightForModel:(RiJiModel *)rijiModel {
    CGFloat titleHeight = [rijiModel.title boundingRectWithSize:CGSizeMake(ScreenSzie.width - 20, 0) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    CGFloat contentHeight = [rijiModel.content boundingRectWithSize:CGSizeMake(ScreenSzie.width - 20, 0) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    if (rijiModel.images.count > 0) {
//        if (rijiModel.images.count < 3) {
//            return titleHeight + contentHeight + 40 + ImageHeight;
//        }
        return titleHeight + contentHeight + 40 +  (rijiModel.images.count/3 + 1)*MoreImageHeight;
    }
    return titleHeight + contentHeight + 30;
}

#pragma mark set

- (void)setRijiModel:(RiJiModel *)rijiModel {
    _rijiModel = rijiModel;
    _titleLab.text = rijiModel.title;
    _contentLab.text = rijiModel.content;
    
    CGFloat titleHeight = [rijiModel.title boundingRectWithSize:CGSizeMake(self.titleLab.frame.size.width, 0) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleHeight);
    }];
    CGFloat contentHeight = [rijiModel.content boundingRectWithSize:CGSizeMake(self.contentLab.frame.size.width, 0) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    [self.contentLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(contentHeight);
    }];
    
    if (_rijiModel.images.count == 0) {
        [self.contentLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        }];
    }
    
    
    [self showImageView];
    [self refreshImageFrame];
}

- (void)showImageView {
    self.imageView1.hidden = YES;
    self.imageView2.hidden = YES;
    self.imageView3.hidden = YES;
    self.imageView4.hidden = YES;
    self.imageView5.hidden = YES;
    self.imageView6.hidden = YES;
    self.imageView7.hidden = YES;
    self.imageView8.hidden = YES;
    self.imageView9.hidden = YES;
    switch (_rijiModel.images.count) {
        case 1:
            self.imageView1.hidden = NO;
            break;
            case 2:
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            break;
        case 3:
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            break;
        case 4:
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            break;
        case 5:
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            break;
        case 6:
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = NO;
            break;
        case 7:
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = NO;
            self.imageView7.hidden = NO;
            break;
        case 8:
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = NO;
            self.imageView7.hidden = NO;
            self.imageView8.hidden = NO;
            break;
        case 9:
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = NO;
            self.imageView7.hidden = NO;
            self.imageView8.hidden = NO;
            self.imageView9.hidden = NO;
            break;
    }
}

- (void)refreshImageFrame {
    CGFloat iamgeWidth = (ScreenSzie.width - 40)/3;
    for (int i = 0; i < _rijiModel.images.count; i++) {
        UIImageView *imageView = [self viewWithTag:101 + i];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(10 + i%3 * iamgeWidth);
            make.top.mas_equalTo(self.contentLab.mas_bottom).mas_offset(20 + (i/3)*iamgeWidth);
            make.width.height.mas_equalTo(iamgeWidth);
        }];
        if (i+1 == self.rijiModel.images.count) {
            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
            }];
        }
        [imageView sd_setImageWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", [[FileManager shareManager] getMianPath], _rijiModel.images[i]]]];
    }
    return;
    if (_rijiModel.images.count > 0 && _rijiModel.images.count < 3) {
        if (_rijiModel.images.count == 1) {
            [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(self.contentLab.mas_bottom).mas_offset(10);
                make.right.mas_equalTo(-10);
            }];
        } else {
            [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(self.contentLab.mas_bottom).mas_offset(10);
                make.right.mas_equalTo(self.imageView2.mas_left).mas_offset(-10);
            }];
            
            [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.imageView1.mas_right).mas_offset(10);
                make.top.mas_equalTo(self.contentLab.mas_bottom).mas_offset(10);
                make.right.mas_offset(-10);
            }];
        }
    } else if (_rijiModel.images.count >= 3) {
        CGFloat iamgeWidth = (ScreenSzie.width - 40)/3;
        for (int i = 0; i < _rijiModel.images.count; i++) {
            CGRect rect = CGRectMake(10 + i%3 * iamgeWidth, _contentLab.tz_bottom + 10 + (i/3)*iamgeWidth, iamgeWidth, iamgeWidth);
            UIImageView *imageView = [self viewWithTag:101 + i];
            imageView.frame = rect;
            [imageView sd_setImageWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", [[FileManager shareManager] getMianPath], _rijiModel.images[i]]]];
        }
    }
}

#pragma mark ui

- (YYLabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [YYLabel new];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (YYLabel *)dateLab {
    if (!_dateLab) {
        _dateLab = [YYLabel new];
    }
    return _dateLab;
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] init];
        _imageView1.tag = 101;
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] init];
        _imageView2.tag = 102;
    }
    return _imageView2;
}

- (UIImageView *)imageView3 {
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] init];
        _imageView3.tag = 103;
    }
    return _imageView3;
}

- (UIImageView *)imageView4 {
    if (!_imageView4) {
        _imageView4 = [[UIImageView alloc] init];
        _imageView4.tag = 104;
    }
    return _imageView4;
}

- (UIImageView *)imageView5 {
    if (!_imageView5) {
        _imageView5 = [[UIImageView alloc] init];
        _imageView5.tag = 105;
    }
    return _imageView5;
}

- (UIImageView *)imageView6 {
    if (!_imageView6) {
        _imageView6 = [[UIImageView alloc] init];
        _imageView6.tag = 106;
    }
    return _imageView6;
}

- (UIImageView *)imageView7 {
    if (!_imageView7) {
        _imageView7 = [[UIImageView alloc] init];
        _imageView7.tag = 107;
    }
    return _imageView7;
}

- (UIImageView *)imageView8 {
    if (!_imageView8) {
        _imageView8 = [[UIImageView alloc] init];
        _imageView8.tag = 108;
    }
    return _imageView8;
}

- (UIImageView *)imageView9 {
    if (!_imageView9) {
        _imageView9 = [[UIImageView alloc] init];
        _imageView9.tag = 109;
    }
    return _imageView9;
}
@end
