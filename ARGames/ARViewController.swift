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
    //let board = NaughtsAndCrosses(height:0.1,width:0.1,length:0.01)
    let board = Draughts(height:0.3,width:0.3, length: 0.01)
    var startNode: Int = 0
    var endNode: Int = 0
    
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
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
            if(hitTestResults.first?.node.parent?.name == "board" && false){
                let node = hitTestResults.first?.node
                if(board.putPiece(to: Int((node?.name!)!)!,type: 0)){
                    if(board.gameState.isWinner){
                        print("you won")
                    }
                    return
                }else{
                    print("oops")
                }
            }
        }
    }
    func addPanGestureToSceneView() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ARViewController.didPan(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(panGestureRecognizer)
    }
    @objc func didPan(withGestureRecognizer recognizer: UIGestureRecognizer){
        switch recognizer.state{
        case .began:
            let startPanLocation = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(startPanLocation)
            
            if(hitTestResults.first?.node.parent?.name != "board"){
                let node = hitTestResults.first?.node.parent
                //print("Start: " + "\(node?.name)")
                startNode = Int((node?.name)!)!
                board.generatePossibleMoves(from: startNode)
            }
        case .cancelled:
            print("cancelled")
        //case .changed:
            //print("changed")
        case .ended:
            let endPanLocation = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(endPanLocation)
            
            if(hitTestResults.first?.node.parent?.name == "board"){
                let node = hitTestResults.first?.node
                //print("end: " + "\(node?.name)")
                endNode = Int((node?.name)!)!
                board.movePiece(from: startNode, to: endNode)
            }
        case .failed:
            print("failed")
        default: break
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
