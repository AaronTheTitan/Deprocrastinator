//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Aaron Bradley on 1/12/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *taskTableView;

@property (strong, nonatomic) IBOutlet UITextField *taskTextField;

@property NSString *userTask;
@property NSMutableArray *userTasksArray;
@property UITableViewCell *cell;

//@property CGPoint taskTouched;

@end



@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.userTasksArray = [[NSMutableArray alloc] init];


}


///////


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle

    forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.userTasksArray removeObjectAtIndex:indexPath.row];
    [self.taskTableView reloadData];
    
}




-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *titleItem = [self.userTasksArray objectAtIndex:sourceIndexPath.row];
    [self.userTasksArray removeObject:titleItem];
    [self.userTasksArray insertObject:titleItem atIndex:destinationIndexPath.row];


    [self.taskTableView reloadData];

}

///////


- (IBAction)onAddButtonPressed:(UIButton *)sender {

    self.userTask = [NSString stringWithFormat:@"%@", self.taskTextField.text];

    [self.userTasksArray addObject: self.taskTextField.text];
    [self.taskTableView reloadData];

    self.taskTextField.text = @"";
    [self.taskTextField endEditing:YES];

}
- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {

    if (self.editing)
    {
        self.editing = false;
        [self.taskTableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.taskTableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }
    [self.taskTableView reloadData];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cellGreen = [self.taskTableView cellForRowAtIndexPath:indexPath];

    cellGreen.textLabel.textColor = [UIColor greenColor];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userTasksArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    self.cell = [tableView dequeueReusableCellWithIdentifier:@"ColorCellID"];
    self.cell.textLabel.text = [self.userTasksArray objectAtIndex:indexPath.row];

    return self.cell;
    
}


@end
