//
//  ViewController.swift
//  tetrahedronEdge
//
//  Created by MizushimaYusuke on 2017/05/15.
//  Copyright © 2017 MizushimaYusuke. All rights reserved.
//

import UIKit
import SceneKit

class tetrahedronEdgeViewController: UIViewController, SCNSceneRendererDelegate {
    
    weak var sceneView: SCNView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        createTetrahdron()
        createCamera()
    }
    
    func setupScene() {
        let sv = SCNView(frame: view.frame)
        sv.scene = SCNScene()
        sv.delegate = self
        sv.allowsCameraControl = true
        view.addSubview(sv)
        sceneView = sv
    }
    
    func createTetrahdron() {
        let pts: [(x: Double,y: Double,z: Double)] = [(-1, -1, -1), (1, -1, 1), (-1, 1, 1), (1, 1, -1)];
        let edges = [[0, 1], [0, 2], [0, 3], [1, 2], [1, 3], [2, 3]]
        
        
        for e in edges {
            let source = SCNGeometrySource.init(vertices:
                [SCNVector3(pts[e[0]].x, pts[e[0]].y, pts[e[0]].z),
                 SCNVector3(pts[e[1]].x, pts[e[1]].y, pts[e[1]].z)])
            let indices : [UInt8] = [0, 1]
            let data = Data.init(bytes: indices)
            let element = SCNGeometryElement.init(data: data, primitiveType: .line, primitiveCount: 1, bytesPerIndex: 1)
            
            let geometry = SCNGeometry.init(sources: [source], elements: [element])
            geometry.firstMaterial?.diffuse.contents = UIColor.gray
            let line = SCNNode.init(geometry: geometry)
            line.name = "line"
            sceneView?.scene?.rootNode.addChildNode(line)
        }
    }
    
    func createCamera() {
        let camera = SCNNode()
        camera.position = SCNVector3(0, 0, 5)
        camera.camera = SCNCamera()
        sceneView?.scene?.rootNode.addChildNode(camera)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        glLineWidth(5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneView?.scene?.rootNode.childNodes
            .filter { $0.name == "line" }
            .forEach {
                if arc4random_uniform(3) == 0 {
                    $0.runAction(SCNAction.rotateBy(x: 2 * .pi, y: 0, z: 0, duration: 1.0))
                }
        }
    }
}
