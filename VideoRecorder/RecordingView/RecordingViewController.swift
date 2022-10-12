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
        previewLayer.frame = self.view.frame
        self.view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global().async {
            session.startRunning()
        }
    }
    
    func addSubView() {
        view.addSubview(recordingView)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
            recordingView.topAnchor.constraint(equalTo: view.bottomAnchor),
            recordingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recordingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recordingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

}


