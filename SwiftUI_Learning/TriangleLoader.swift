//
//  ContentView.swift
//  SwiftUI_Learning
//
//  Created by Ashish Sharma on 09/12/20.
//

import SwiftUI

struct Logo: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ContentView: View {
    
    // MARK:- variables
    @State var resetStrokes: Bool = true
    @State var strokeStart: CGFloat = 0
    @State var strokeEnd: CGFloat = 0.2
    @State var speed: CGFloat = 0.1
       
    var body: some View {
        ZStack {
                   Color.black
                       .edgesIgnoringSafeArea(.all)
        Logo()
        .fill(Color.red)
        .frame(width: 50, height: 60)
        Logo()
        .trim(from: strokeStart, to: strokeEnd)
        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 10))
        .frame(width: 60, height: 70)
        .foregroundColor(Color.white)
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
                if (self.strokeEnd >= 1) {
                    if (self.resetStrokes) {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                            self.strokeEnd = 0
                            self.strokeStart = 0
                            self.resetStrokes.toggle()
                        }
                        self.resetStrokes = false
                    }
                }
                withAnimation(Animation.easeOut(duration: 0.5)) {
                    self.strokeEnd += 0.1
                    self.strokeStart = self.strokeEnd - 0.3
                }
            }
        }
    }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
