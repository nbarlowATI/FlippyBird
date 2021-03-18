//
//  ViewController.swift
//  Flip1
//
//  Created by Nicholas Barlow on 25/06/2015.
//  Copyright (c) 2015 Nicholas Barlow. All rights reserved.
//

import UIKit
import AVFoundation
import SceneKit

class ViewController: UIViewController {

    
    @IBOutlet weak var handTouch: UIImageView!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice!)
        } catch {
            return
        }
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
    
   /* THIS IS FROM THE XCODE 7 VERSION
        let devices = AVCaptureDevice.devices()
        // Loop through all the capture devices on this phone
        for device in devices! {
            // Make sure this particular device supports video
            if ((device as AnyObject).hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if((device as AnyObject).position == AVCaptureDevicePosition.back ) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        if captureDevice != nil {
            beginSession()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
 */
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning();
        }
        self.view.bringSubview(toFront: handTouch)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: readableObject.stringValue!);
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    func failed() {
               captureSession = nil
    }
    
/** FROM XCODE 7 VERSION
    func beginSession() {
        
        let err : NSError? = nil
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch _ {
            print("error: \(err?.localizedDescription)")
        }
                
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait;
        previewLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer!)

        //let sceneView = SCNView()
       // sceneView.frame = self.view.bounds
       // sceneView.backgroundColor = UIColor.clear
       // self.view.addSubview(sceneView)
        captureSession.startRunning()
       // self.view.sendSubview(toBack: sceneView)
        //previewLayer?.frame = self.view.layer.frame
    
        self.view.bringSubview(toFront: handTouch)
       
    }
    */
        
    //////////// TRY THIS

//        @IBOutlet weak var cameraView: UIView!
  //      var captureSession = AVCaptureSession();
   //     var sessionOutput = AVCapturePhotoOutput();
    //    var sessionOutputSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecJPEG]);
    //    var previewLayer = AVCaptureVideoPreviewLayer();
      /*
        override func viewWillAppear(_ animated: Bool) {
        let deviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInDuoCamera, AVCaptureDeviceType.builtInTelephotoCamera,AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified)
            for device in (deviceDiscoverySession?.devices)! {
                if(device.position == AVCaptureDevicePosition.front){
                    do{
                        let input = try AVCaptureDeviceInput(device: device)
                        if(captureSession.canAddInput(input)){
                            captureSession.addInput(input);
                            
                            if(captureSession.canAddOutput(sessionOutput)){
                                captureSession.addOutput(sessionOutput);
                                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
                                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                                previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait;
                                cameraView.layer.addSublayer(previewLayer);
                            }
                        }
                    }
                    catch{
                        print("exception!");
                    }
                }
            }
        }
    */
    ///////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let image1 = UIImage(named: "hand2a")
        handTouch.image = image1
      
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let image0 = UIImage(named: "hand1a")
        handTouch.image = image0

    }

//    override var shouldAutorotate : Bool {
  //      get {
     //       return false
    //    }
    /*    if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.Unknown) {
                return false
        }
        else {
            return true
        } */
   // }
    
//    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
  //      return [UIInterfaceOrientationMask.portrait]
   // }

}

