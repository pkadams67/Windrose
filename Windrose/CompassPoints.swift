//  See LICENSE folder for this sample’s licensing information.
//  Abstract: Compass Points — provides the azimuth, names, and points.

import UIKit
import SceneKit

class CompassPoints: NSObject {
    
    var angle: Float
    var name: String
    
    init(angle: Float, name: String) {
        self.angle = angle
        self.name  = name
        super.init()
    }
    
    func sphere() -> SCNNode {
        let sphere                      = SCNSphere(radius: 1.5)
        let sphereMaterial              = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.magenta
        let node                        = SCNNode(geometry: sphere)
        node.geometry?.materials        = [sphereMaterial]
        node.transform                  = CompassPoints.transform(rotationY: GLKMathDegreesToRadians(angle), distance: 100)
        return node
    }
    
    func text() -> SCNNode {
        let textBlock                             = SCNText(string: "\(angle)°\n\(name)", extrusionDepth: 0.5)
        textBlock.font                            = UIFont (name: "Futura-Medium", size: 6)
        textBlock.firstMaterial?.diffuse.contents = UIColor.cyan
        textBlock.flatness                        = 0.25
        let node                                  = SCNNode(geometry: textBlock)
        node.transform                            = CompassPoints.transform(rotationY: GLKMathDegreesToRadians(angle), distance: 100)
        return node
    }
    
    static func transform(rotationY: Float, distance: Int) -> SCNMatrix4 {
        // Translate first on -z direction
        let translation = SCNMatrix4MakeTranslation(0, 0, Float(-distance))
        // Rotate (yaw) around y axis
        let rotation    = SCNMatrix4MakeRotation(-1 * rotationY, 0, 1, 0)
        // Final transformation: TxR
        let transform   = SCNMatrix4Mult(translation, rotation)
        return transform
    }
}

extension CompassPoints {
    static let defaults: [CompassPoints] = {
        return [
            CompassPoints(angle:   0, name: "North"),
            CompassPoints(angle:  45, name: "Northeast"),
            CompassPoints(angle:  90, name: "East"),
            CompassPoints(angle: 135, name: "Southeast"),
            CompassPoints(angle: 180, name: "South"),
            CompassPoints(angle: 225, name: "Southwest"),
            CompassPoints(angle: 270, name: "West"),
            CompassPoints(angle: 315, name: "Northwest"),
            ]
    }()
}
