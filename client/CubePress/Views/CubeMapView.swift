//
//  CubeMapView.swift
//  CubePress
//
//  Created by Robert Bates on 3/9/23.
//

import SwiftUI


//abstract into cubemapmodel file

struct CubeMapView: View {
    @ObservedObject var model: CubeMapModel
    
    var body: some View {
        Grid{
            GridRow{
                Color.white
                //top
                CubeFaceView(model: model.U)
                Color.white
            }
            GridRow{
                CubeFaceView(model: model.L)
                CubeFaceView(model: model.F)
                CubeFaceView(model: model.R)
                //front 3 sides
            }
            GridRow{
                Color.white
                //bottom
                CubeFaceView(model: model.D)
                Color.white
            }
            GridRow{
                Color.white
                //back
                CubeFaceView(model: model.B)
                Color.white
            }
        }
        .aspectRatio(contentMode: .fit)
        .padding()
    }
}

struct CubeFaceView: View {
    var model: Face
    
    var body: some View {
        Grid {
            GridRow{
                Color(model.topLeft)
                Color(model.topCenter)
                Color(model.topRight)
            }
            GridRow{
                Color(model.midLeft)
                Color(model.midCenter)
                Color(model.midRight)
            }
            GridRow{
                Color(model.bottomLeft)
                Color(model.bottomCenter)
                Color(model.bottomRight)
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}


struct CubeMapView_Previews: PreviewProvider {
    static var previews: some View {
        CubeMapView(model: CubeMapModel())
    }
}
