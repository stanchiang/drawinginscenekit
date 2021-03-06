//
//  ViewController.swift
//  HandwriteTo3D
//
//  Created by MizushimaYusuke on 10/7/15.
//  Copyright © 2015 MizushimaYusuke. All rights reserved.
//

import UIKit
import SceneKit

class HandwriteTo3DViewController: UIViewController {
    
    weak var sceneView : SCNView?
    weak var canvas : CAShapeLayer?
    var drawPath : UIBezierPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.history, tag: 1)
        setupScene()
        createTable()
        createCamera()
    }
    
    func setupScene() {
        let sv = SCNView(frame: view.bounds)
        sv.scene = SCNScene()
        sv.autoenablesDefaultLighting = true
        view.addSubview(sv)
        
        sceneView = sv
        
        let cv = CAShapeLayer()
        cv.fillColor = UIColor.clear.cgColor
        cv.strokeColor = UIColor.green.cgColor
        cv.lineWidth = 3
        
        view.layer.addSublayer(cv)
        canvas = cv
        
    }
    
    func createTable() {
        let ge = SCNCylinder(radius: 5, height: 0.2)
        ge.firstMaterial?.diffuse.contents = UIColor.brown
        let table = SCNNode(geometry: ge)
        table.position = SCNVector3(0, -10, 0)
        sceneView?.scene?.rootNode.addChildNode(table)
        
        table.physicsBody = SCNPhysicsBody.static()
    }
    
    func createCamera() {
        let camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(0, 0, 20)
        camera.rotation = SCNVector4(1, 0, 0, -0.2)
        sceneView?.scene?.rootNode.addChildNode(camera)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let p = touch.location(in: view)
            
            let cv = CAShapeLayer()
            cv.fillColor = UIColor.clear.cgColor
            cv.strokeColor = UIColor.green.cgColor
            cv.lineWidth = 3
            view.layer.addSublayer(cv)
            canvas = cv
            
            drawPath = UIBezierPath()
            drawPath?.move(to: p)
            canvas?.path = drawPath?.cgPath
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let canvas = canvas {
            let p = touch.location(in: view)
            drawPath?.addLine(to: p)
            canvas.path = drawPath?.cgPath
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var trans = CGAffineTransform(scaleX: 1.0 / 60.0, y: 1.0 / 60.0)
        let cgp = canvas!.path!.copy(using: &trans)
        let path = UIBezierPath(cgPath: cgp!)
        path.close()
        let g = SCNShape(path: path, extrusionDepth: 2)
        g.firstMaterial?.diffuse.contents = UIColor.green
        let node = SCNNode(geometry: g)
        node.physicsBody = SCNPhysicsBody.dynamic()
        sceneView?.scene?.rootNode.addChildNode(node)
        
        canvas?.removeFromSuperlayer()

    }
}
