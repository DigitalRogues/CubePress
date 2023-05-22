//
//  CubeMapModel.swift
//  CubePress
//
//  Created by Robert Bates on 3/15/23
//

import Foundation
import UIKit
import SwiftUI

//needs to look at a published property, cubeFace, in frame model.  will hand this model the property that it needs
//needs to be made observable

@MainActor
class CubeMapModel: ObservableObject {
    
    var faces = [ "U" : Face(),
                  "L" : Face(),
                  "F" : Face(),
                  "R" : Face(),
                  "B" : Face(),
                  "D" : Face(), ]
    
    //@Published var U =  Face()
    @Published var U =  Face()
    @Published var L =  Face()
    @Published var F =  Face()
    @Published var R =  Face()
    @Published var B =  Face()
    @Published var D =  Face()
    
    //add function needs to add based on orientation of cube, not color of center square
    func add(face: Face) {
        //add face based on center color
        switch face.midCenter {
        case .orange:
            F = face
        case .white:
            U = face
        case .green:
            R = face
        case .blue:
            L = face
        case .red:
            B = face
        case .yellow:
            D = face
        default:
            break
        }
    }
    
    fileprivate func saveFacePicturesFrom(_ face: Face) {
        for i in face.sourceImages {
            // Obtaining the Location of the Documents Directory
            let documents = FileManager.default.urls(for: .documentDirectory, in: 2)[0]

            // Create URL
            let url = documents.appendingPathComponent("image.png")

            // Convert to Data
            if let data = i.pngData() {
                do {
                    try data.write(to: url)
                } catch {
                    print("Unable to Write Image Data to Disk")
                }
            }
        }
    }
    
    func saveMapPictures() {
        saveFacePicturesFrom(U)
        saveFacePicturesFrom(L)
        saveFacePicturesFrom(F)
        saveFacePicturesFrom(R)
        saveFacePicturesFrom(B)
        saveFacePicturesFrom(D)
    }
}

struct Face {
    //a data structure that represents one face of the rubix cube
    var sourceImages: [UIImage] = []
    var topLeft = UIColor.black
    var topCenter = UIColor.black
    var topRight = UIColor.black
    var midLeft = UIColor.black
    var midCenter = UIColor.black
    var midRight = UIColor.black
    var bottomLeft = UIColor.black
    var bottomCenter = UIColor.black
    var bottomRight = UIColor.black
}

enum CubeFace: String, CaseIterable, Identifiable, Codable {
    var id: String {rawValue}
    
    case U, D, R, L, F, B
}

enum FaceSquare: String, CaseIterable, Identifiable, Codable {
    var id: String {rawValue}
    
    case topLeft, topCenter, topRight,
         midLeft, midCenter, midRight,
         bottomLeft, bottomCenter, bottomRight
}
