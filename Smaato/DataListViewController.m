//
//  ViewController.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "DataListViewController.h"
#import "ViewModel.h"
#import "ImageTableViewCell.h"
#import "TextTableViewCell.h"
#import "ListDataModel.h"
#import "Constants.h"
#import "ImageCacheHelper.h"
#import "FavouritesViewController.h"
#import "UIStoryboard+Manager.h"

@interface DataListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) ViewModel *viewModel;
@property(strong, nonatomic) ImageCacheHelper *imageCacheHelper;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation DataListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.viewModel = [[ViewModel alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:NIBTextTableViewCell bundle:nil] forCellReuseIdentifier: TextTableViewCellIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NIBImageTableViewCell bundle:nil] forCellReuseIdentifier:ImageTableViewCellIdentifier];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.imageCacheHelper = [[ImageCacheHelper alloc] init];
    
    UIBarButtonItem *favouritesButton = [[UIBarButtonItem alloc]
                                      initWithTitle:NSLocalizedString(@"FavouritesKey", nil)
                                      style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(showFavourites)];
    self.navigationItem.rightBarButtonItem = favouritesButton;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.viewModel fetchListCompletion:^(NSMutableArray *dataArray, NSError *error) {
        self.dataArray = dataArray;
        [self.tableView reloadData];
    }];
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
        cell.favouriteButton.selected = listDataModel.favourite;
        cell.favouriteButton.tag = indexPath.row;
        [cell.favouriteButton addTarget:self  action:@selector(favourite:) forControlEvents:UIControlEventTouchUpInside];

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
        cell.favouriteButton.tag = indexPath.row;
        cell.favouriteButton.selected = listDataModel.favourite;
        [cell.favouriteButton addTarget:self  action:@selector(favourite:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ImageTextCellHeight;
}

#pragma mark - Actions

- (void)showFavourites {
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.favourite = true"];
    NSArray *filteredArray = [self.dataArray filteredArrayUsingPredicate:bPredicate];
    
    FavouritesViewController *favouritesViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:StoryBoardIdFavouritesViewController];
    favouritesViewController.dataArray = filteredArray;
    [self.navigationController pushViewController:favouritesViewController animated:YES];
}

- (void)favourite:(UIButton*)button {
    ListDataModel *listDataModel = self.dataArray[(NSUInteger) button.tag];
    listDataModel.favourite = !listDataModel.favourite;
    button.selected = listDataModel.favourite;
}

@end
