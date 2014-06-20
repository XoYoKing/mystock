//
//  SuggestTableViewCell.m
//  mystock
//
//  Created by Ryan on 14-6-20.
//  Copyright (c) 2014年 Ryan. All rights reserved.
//

#import "SuggestTableViewCell.h"

@implementation SuggestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 80, 20)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = HEI_(18);
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"鸿博股份";
        [self addSubview:_nameLabel];
        
        self.codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 33, 80, 12)];
        _codeLabel.backgroundColor = [UIColor clearColor];
        _codeLabel.font = HEI_(10);
        _codeLabel.textColor = [UIColor lightGrayColor];
        _codeLabel.text = @"002229";
        [self addSubview:_codeLabel];
        
        self.closeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 12, 80, 20)];
        _closeLabel.textAlignment = NSTextAlignmentRight;
        _closeLabel.backgroundColor = [UIColor clearColor];
        _closeLabel.font = HEI_(18);
        _closeLabel.textColor = [UIColor whiteColor];
        _closeLabel.text = @"收盘价";
        [self addSubview:_closeLabel];
        
        self.percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 5, 80, 34)];
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        _percentLabel.backgroundColor = [UIColor clearColor];
        _percentLabel.font = HEI_(18);
        _percentLabel.textColor = [UIColor whiteColor];
        _percentLabel.text = @"涨跌幅";
        [self addSubview:_percentLabel];
        
        UIView *tempView = [[UIView alloc] initWithFrame:self.bounds];
        tempView.backgroundColor = NAVI_COLOR;
        self.selectedBackgroundView = tempView;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(NSDictionary *)cellDic{
    _nameLabel.text = [cellDic objForKey:@"name"];
    _codeLabel.text = [cellDic objForKey:@"code"];
    
    float percent = [[cellDic objForKey:@"percent"] floatValue];
    if (percent >= 0) {
        _percentLabel.backgroundColor = RED_COLOR;
    }else{
        _percentLabel.backgroundColor = DARK_GREEN_COLOR;
    }
    
    _closeLabel.text = [NSString stringWithFormat:@"%.2f",[[cellDic objForKey:@"close"] floatValue]];
    _percentLabel.text = [[NSString stringWithFormat:@"%.2f",percent] stringByAppendingString:@"%"];
}

@end
