//
//  TTCTableViewCell.m
//  TerrableTCellMode
//
//  Created by 肖冯敏 on 2021/8/27.
//

#import "TTCTableViewCell.h"
#import "Masonry.h"

@interface TTCTableViewCell()

@property (nonatomic, strong) UIView *panel;

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *titlePanel;

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
    
    _panel = ^{
        UIView *v = [UIView new];
        return v;
    }();
    
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
        l.numberOfLines = 0;
        return l;
    }();
    
    _dateLabel = ^{
        UILabel *l = [[UILabel alloc] init];
        return l;
    }();
    
    _titlePanel = ^{
        UILabel *l = [[UILabel alloc] init];
        return l;
    }();
    
    [self.contentView addSubview:_panel];
    [self.panel addSubview:_avatar];
    [self.panel addSubview:_titlePanel];
    [self.titlePanel addSubview:_titleLabel];
    [self.titlePanel addSubview:_dateLabel];
    [self.panel addSubview:_contentLabel];
    
}

- (void)masSubviews {
    
    [self.panel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.panel).offset(16);
        make.height.width.equalTo(@32);
    }];
    
    _titlePanel.backgroundColor = [UIColor redColor];

    [_titlePanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_avatar);
        make.left.equalTo(_titleLabel);
        make.right.greaterThanOrEqualTo(_titleLabel);
        make.right.greaterThanOrEqualTo(_dateLabel);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(16);
        make.top.equalTo(_titlePanel);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.bottom.equalTo(_titlePanel);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.avatar.mas_bottom).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.bottom.equalTo(self.panel).offset(-16);
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
    NSString *date = dic[@"date"]?:@"";
    
    [_avatar setImage:[UIImage imageNamed:imgName]];
    _titleLabel.text = title;
    _contentLabel.text = content;
    _dateLabel.text = date;
    
    if ([date length] > 0) {
        [_dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(8);
        }];
    } else {
        [_dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        }];
    }
    
}

@end
