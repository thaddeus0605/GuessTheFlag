//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Thaddeus Dronski on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var playerScore = 0
    
    @State private var alertMessage = ""
    
    @State private var gameCounter = 0
    
    @State private var gameOverAlert = false
    @State private var gameOverText = "Game Over!"
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(playerScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            //flag was tapped
                            flagTapped(number)
                            print("Flag tap")
                        } label: {
                           FlagImage(name: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertMessage)
        }
        .alert(gameOverText, isPresented: $gameOverAlert) {
            Button("Reset Game", action: reset)
        } message: {
            Text("Game over!")
        }
    }
    
    func flagTapped(_ number: Int) {
        gameCounter += 1
        
        if gameCounter < 9 {
            if number == correctAnswer  {
                scoreTitle = "Correct"
                playerScore += 1
                alertMessage = "You got it right!"
                showingScore = true
              } else {
                scoreTitle = "Wrong"
                alertMessage = "Yeah sorry bud, Thats the flag of \(countries[number])"
                showingScore = true
            }
        } else {
            showingScore = false
            gameOverAlert = true
            print("Game Over")
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        gameOverAlert = false
        gameCounter = 0
        playerScore = 0
    }
    
}

struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
