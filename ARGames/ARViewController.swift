//
//  ARViewController.swift
//  ARGames
//
//  Created by james atkinson on 05/03/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import UIKit
import ARKit

class ARViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToSceneView()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
//    func addBoard(x: Float = 0, y: Float = 0, z: Float = -0.2) {
//        let box = SCNBox(width: 0.1, height: 0.01, length: 0.1, chamferRadius: 0)
//        
//        let boxNode = SCNNode()
//        boxNode.geometry = box
//        boxNode.position = SCNVector3(x, y, z)
//        print(boxNode)
//        sceneView.scene.rootNode.addChildNode(boxNode)
//    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                let board = NaughtsAndCrosses(height:0.1,width:0.1,length:0.01,x: translation.x,y:translation.y,z:translation.z)
                sceneView.scene.rootNode.addChildNode(board.node)
                //addBoard(x: translation.x, y: translation.y, z: translation.z)
            }
            return
        }
        node.removeFromParentNode()
    }

}
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

//extension ViewController: ARSCNViewDelegate{
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard let surfaceAnchor = anchor as? ARPlaneAnchor else{return}
//
//        let box = SCNBox(width: 0.1, height: 0.01, length: 0.1, chamferRadius: 0)
//
//        box.materials.first?.diffuse.contents = UIColor.blue
//
//        let surfaceNode = SCNNode(geometry: box)
//
//        let x = CGFloat(surfaceAnchor.center.x)
//        let y = CGFloat(surfaceAnchor.center.y)
//        let z = CGFloat(surfaceAnchor.center.z)
//        surfaceNode.position = SCNVector3(x,y,z)
//        //surfaceNode.eulerAngles.x = -.pi / 2
//
//        node.addChildNode(surfaceNode)
//    }
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        guard let planeAnchor = anchor as?  ARPlaneAnchor,
//            let planeNode = node.childNodes.first,
//            let plane = planeNode.geometry as? SCNPlane
//            else { return }
//
//        let width = CGFloat(planeAnchor.extent.x)
//        let height = CGFloat(planeAnchor.extent.z)
//        plane.width = width
//        plane.height = height
//
//        let x = CGFloat(planeAnchor.center.x)
//        let y = CGFloat(planeAnchor.center.y)
//        let z = CGFloat(planeAnchor.center.z)
//        planeNode.position = SCNVector3(x, y, z)
//    }
//}
