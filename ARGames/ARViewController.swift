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
    let board = NaughtsAndCrosses(height:0.1,width:0.1,length:0.01)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToSceneView()
        addPanGestureToSceneView()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        //sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
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
    func addPanGestureToSceneView() {
        
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        if(sceneView.scene.rootNode.childNode(withName: "board", recursively: false) == nil){
            guard let node = hitTestResults.first?.node else {
                let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
                
                if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                    var translation = hitTestResultWithFeaturePoints.worldTransform.translation
                    board.placeBoard(x: translation.x,y: translation.y,z: translation.z)
                    sceneView.scene.rootNode.addChildNode(board.boardNode)
                }
                return
            }
            node.removeFromParentNode()
        }else{
            //need to rethink this function
            if(Int((hitTestResults.first?.node.name)!) != nil){
                let node = hitTestResults.first?.node
                if(board.putPiece(to: Int((node?.name!)!)!)){
                    if(board.gameState.isWinner){
                        print("you won")
                    }
                    return
                }else{
                    print("oops")
                }
            }
//            print("before gaurd")
//            guard let node = hitTestResults.first?.node, node.name == "1" else {
//                let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
//                print("inside guard")
//                if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
//                    var translation = hitTestResultWithFeaturePoints.worldTransform.translation
//                    //sceneView.scene.rootNode.childNode(withName: "board", recursively: false)?.childNode(withName: "1", recursively: false)?.addChildNode(board.)
//                }
//                return
//            }
            
            //print(sceneView.scene.rootNode.childNode(withName: "board", recursively: false)!)
        }
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
