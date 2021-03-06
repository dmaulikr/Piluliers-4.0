//
//  BarCodeViewController.m
//  Piluliers 4.0
//
//  Created by Projet REACH on 12.05.17.
//  Copyright © 2017 Post CH AG. All rights reserved.
//

#import "BarCodeViewController.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "MainMenuTabBarController.h"
#import "RestManager.h"
#import "UIColor+CustomColors.h"

@interface BarCodeViewController ()

@end
RestManager * restManager;
@implementation BarCodeViewController



-(void)scan{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:vc animated:YES completion:NULL];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Lecteur non pris en charge par le périphérique actuel" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [reader stopScanning];
    
    [self dismissViewControllerAnimated:YES completion:^{

        [restManager fetchPatientDataForPatient:result withCompletionBlock:(^(NSError* err){
            if(err==nil){
                NSLog(@"%@",result);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"userId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self goToMainMenu];
            }
            else{
                NSLog(@"%@",err);
            }
        })];
	
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
       // [alert show];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
/**/



- (void)login {
    
    NSString * userId = _loginUITextField.text;
    
    [restManager fetchPatientDataForPatient:userId withCompletionBlock:(^(NSError* err){
        if(err==nil){
            
            
            NSLog(@"%@",userId);
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self goToMainMenu];
        }
        else{
            NSLog(@"%@",err);
        }
    })];
    //[self goToMainMenu];
}
- (IBAction)LoginAction:(id)sender {

    NSString * userId = _loginUITextField.text;

    [restManager fetchPatientDataForPatient:userId withCompletionBlock:(^(NSError* err){
        if(err==nil){
            
      
            NSLog(@"%@",userId);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self goToMainMenu];
        }
        else{
            NSLog(@"%@",err);
        }
    })];
    NSLog(@"%@",userId);
    //[self goToMainMenu];
}

-(void)goToMainMenu{
    
    UIViewController * vc = [[MainMenuTabBarController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    restManager = [RestManager sharedInstance];
    self.view.backgroundColor = [UIColor hackathonAccentColor];
    self.title = @"Pilulier 4.0";
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qrcode"] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];

    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
