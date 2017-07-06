//
//  FavouritesViewController.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "FavouritesViewController.h"
#import "ViewModel.h"
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
    // Do any additional setup after loading the view.
    [self.favouritesTableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier: TextTableViewCellIdentifier];
    
    [self.favouritesTableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:ImageTableViewCellIdentifier];
    
    
    self.favouritesTableView.dataSource = self;
    self.favouritesTableView.delegate = self;
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListDataModel *listDataModel = self.dataArray[indexPath.row];
    if (listDataModel.dataTypeEnum == DataTypeImage) {
        ImageTableViewCell *cell = [self.favouritesTableView dequeueReusableCellWithIdentifier:ImageTableViewCellIdentifier];
        cell.nameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"NameKey", nil), listDataModel.userModel.name];
        cell.countryLabel.text = [NSString stringWithFormat:NSLocalizedString(@"CountryKey", nil), listDataModel.userModel.country];
        cell.createdLabel.text = listDataModel.createdString;
        cell.favouriteButton.hidden = YES;
        if (listDataModel.image == nil) {
            
            FavouritesViewController*__weak weakSelf = self;
            [self.imageCacheHelper fetchImageFromUrl:listDataModel.dataModel.dataUrl
                                           onDidLoad:^(UIImage *image) {
                                               if (image != nil) {
                                                   listDataModel.image = image;
                                                   [weakSelf.favouritesTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                               }
                                           }];
        } else {
            cell.dataImageView.image = listDataModel.image;
        }
        
        return cell;
    } else {
        TextTableViewCell *cell = [self.favouritesTableView dequeueReusableCellWithIdentifier: TextTableViewCellIdentifier];
        cell.nameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"NameKey", nil), listDataModel.userModel.name];
        cell.countryLabel.text = [NSString stringWithFormat:NSLocalizedString(@"CountryKey", nil), listDataModel.userModel.country];
        cell.descriptionLabel.text = listDataModel.dataModel.dataText;
        cell.createdLabel.text = listDataModel.createdString;
        cell.favouriteButton.hidden = YES;
        return cell;
    }
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155;
}

@end
