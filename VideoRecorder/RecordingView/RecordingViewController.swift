//
//  RecordingViewController.swift
//  VideoRecorder
//
//  Created by KangMingyo on 2022/10/11.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController {
    
    private lazy var captureDevice = AVCaptureDevice.default(for: .video)
    private var session: AVCaptureSession?
    private var output = AVCapturePhotoOutput()

    let recordingView: RecordingView = {
       let view = RecordingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingCamera()
 
        view.backgroundColor = .white
        addSubView()
        configure()
        
        recordingView.cencelButton.addTarget(self, action: #selector(cencelButtonPressed), for: .touchUpInside)
        recordingView.rotateButton.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)
    }
    
    func settingCamera() {
        guard let captureDevice = captureDevice else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session = AVCaptureSession()
            session?.sessionPreset = .photo
            session?.addInput(input)
            session?.addOutput(output)
        } catch {
            print(error)
        }
        guard let session = session else { return }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = self.view.frame
        self.view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global().async {
            session.startRunning()
        }
    }
    
    @objc func cencelButtonPressed() {
        self.dismiss(animated: true)
    }
    
    //카메라 방향 전환
    @objc func switchCamera() {
        session?.beginConfiguration()
        let currentInput = session?.inputs.first as? AVCaptureDeviceInput
        session?.removeInput(currentInput!)
        let newCameraDevice = currentInput?.device.position == .back ? getCamera(with: .front) : getCamera(with: .back)
        let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice!)
        session?.addInput(newVideoInput!)
        session?.commitConfiguration()
    }

    func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {

        guard let devices = AVCaptureDevice.devices(for: AVMediaType.video) as? [AVCaptureDevice] else {
            return nil
        }
        return devices.filter {
            $0.position == position
            }.first
    }
    
    func addSubView() {
        view.addSubview(recordingView)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
            recordingView.topAnchor.constraint(equalTo: view.topAnchor),
            recordingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recordingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recordingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

}


