//
//  TTCTableViewCell.m
//  TerrableTCellMode
//
//  Created by 肖冯敏 on 2021/8/27.
//

#import "TTCTableViewCell.h"
#import "Masonry.h"

@interface TTCTableViewCell()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation TTCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        [self masSubviews];
    }
    return self;
}

- (void)initSubviews {
    _avatar = ^{
        UIImageView *imgV = [[UIImageView alloc] init];
        return imgV;
    }();
    
    _titleLabel = ^{
        UILabel *l = [[UILabel alloc] init];
        return l;
    }();
    
    _contentLabel = ^{
        UILabel *l = [[UILabel alloc] init];
        return l;
    }();
    
    [self.contentView addSubview:_avatar];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_contentLabel];
    
}

- (void)masSubviews {
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@16);
        make.height.width.equalTo(@32);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(16);
        make.centerY.equalTo(_avatar);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.avatar.mas_bottom).offset(16);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)updateDataWithDic:(NSDictionary *)dic {
    NSString *imgName = dic[@"avatar"]?:@"";
    NSString *title = dic[@"title"]?:@"";
    NSString *rightBtnTitle = dic[@"rightBtn"]?:@"";
    NSString *content = dic[@"content"]?:@"";
    NSString *contentImg = dic[@"contentImg"]?:@"";
    NSString *topic = dic[@"topic"]?:@"";
    NSString *ext = dic[@"ext"]?:@"";
    
    [_avatar setImage:[UIImage imageNamed:imgName]];
    _titleLabel.text = title;
    _contentLabel.text = content;
}

@end
