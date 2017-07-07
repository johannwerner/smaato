//
//  FavouritesViewController.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "FavouritesViewController.h"
#import "ImageTableViewCell.h"
#import "TextTableViewCell.h"
#import "ListDataModel.h"
#import "Constants.h"
#import "ImageCacheHelper.h"

@interface FavouritesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *favouritesTableView;

@property(strong, nonatomic) ImageCacheHelper *imageCacheHelper;

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.favouritesTableView registerNib:[UINib nibWithNibName:NIBTextTableViewCell bundle:nil] forCellReuseIdentifier: TextTableViewCellIdentifier];
    
    [self.favouritesTableView registerNib:[UINib nibWithNibName:NIBImageTableViewCell bundle:nil] forCellReuseIdentifier:ImageTableViewCellIdentifier];
    
    
    self.favouritesTableView.dataSource = self;
    self.favouritesTableView.delegate = self;
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListDataModel *listDataModel = self.dataArray[(NSUInteger) indexPath.row];
    
    if (listDataModel.dataTypeEnum == DataTypeImage) {
        
        ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageTableViewCellIdentifier];
        cell.nameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"NameKey", nil), listDataModel.userModel.name];
        cell.countryLabel.text = [NSString stringWithFormat:NSLocalizedString(@"CountryKey", nil), listDataModel.userModel.country];
        cell.createdLabel.text = listDataModel.createdString;
        cell.favouriteButton.hidden = true;
        cell.favouriteButton.selected = listDataModel.favourite;
        
        if (listDataModel.image == nil) {
            
            [self.imageCacheHelper fetchImageFromUrl:listDataModel.dataModel.dataUrl
                                           onDidLoad:^(UIImage *image) {
                                               if (image != nil) {
                                                   listDataModel.image = image;
                                                   cell.dataImageView.image = image;
                                               } else {
                                                   cell.dataImageView.image = nil;
                                               }
                                           }];
        } else {
            if ([listDataModel.image isKindOfClass:[UIImage class]]) {
                cell.dataImageView.image = listDataModel.image;
            }
        }
        
        return cell;
    } else {
        
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TextTableViewCellIdentifier];
        cell.nameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"NameKey", nil), listDataModel.userModel.name];
        cell.countryLabel.text = [NSString stringWithFormat:NSLocalizedString(@"CountryKey", nil), listDataModel.userModel.country];
        cell.descriptionLabel.text = listDataModel.dataModel.dataText;
        cell.createdLabel.text = listDataModel.createdString;
        cell.favouriteButton.hidden = YES;
        cell.favouriteButton.selected = listDataModel.favourite;
        
        return cell;
    }
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ImageTextCellHeight;
}

@end
