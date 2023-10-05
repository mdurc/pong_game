//
//  ContentView.swift
//  pong_game
//
//  Created by Matthew Durcan on 10/4/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var ballPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: 50)
    @State private var ballVelocity: CGPoint = CGPoint(x: [-0.267, -0.167, 0.167, 0.267].randomElement()!, y: 0.00167)
    @State private var rectPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height-400)
    @State private var gravity: CGFloat = 0.0006
    @State private var score = 0

    var body: some View {
        ZStack{
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.mint)
                .position(ballPosition)
            
            
            Text("Score: \(score)")
                .foregroundColor(.white)
                .fontWeight(.heavy)
            
            Rectangle()
                .foregroundColor(.pink)
                .frame(width: 100, height: 18)
                .background(Color.pink)
                .cornerRadius(10)
                .position(rectPosition)
                .gesture(DragGesture()
                    .onChanged { value in
                        rectPosition.x = value.location.x
                    }
                )
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.black)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
                ballVelocity.y += gravity
                ballPosition.x += ballVelocity.x
                ballPosition.y += ballVelocity.y
                

                if ballPosition.y > UIScreen.main.bounds.size.height - 60 {
                    ballPosition.y = UIScreen.main.bounds.size.height - 60
                    ballVelocity.y = -1
                    score = 0
                    if (ballVelocity.x > 0){
                        ballVelocity.x = [0.167, 0.267].randomElement()!
                    }else{
                        ballVelocity.x = [-0.267, -0.167].randomElement()!
                    }
                }
                if ballPosition.y < 0 {
                    ballPosition.y = 0
                    ballVelocity.y *= -1
                }
                if ballPosition.x < 10 {
                    ballPosition.x = 10
                    ballVelocity.x *= -1
                }
                if ballPosition.x > UIScreen.main.bounds.size.width - 20 {
                    ballPosition.x = UIScreen.main.bounds.size.width - 20
                    ballVelocity.x *= -1
                }
                
                checkCollision()
            }
        }
    }
    private func checkCollision() {
        if (ballPosition.y < rectPosition.y + 20 && ballPosition.y > rectPosition.y - 20 && ballPosition.x < rectPosition.x + 56 && ballPosition.x > rectPosition.x - 56){
            if (ballVelocity.y > 0){
                if (score<9){
                    ballPosition.y = rectPosition.y - 20
                    ballVelocity.y *= -1.07
                    ballVelocity.x *= 1.10
                }else{
                    ballPosition.y = rectPosition.y - 20
                    ballVelocity.y *= -1.02
                    ballVelocity.x *= 1.04
                }
                score += 1
            }else{
                ballPosition.y = rectPosition.y + 20
                ballVelocity.y *= -1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
