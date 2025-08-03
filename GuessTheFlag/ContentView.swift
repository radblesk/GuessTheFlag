//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Radoslav Bley on 03/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
        "Spain", "UK", "Ukraine", "US",
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var tries: Int = 0

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(
                        color: Color(red: 0.1, green: 0.2, blue: 0.45),
                        location: 0
                    ), .init(color: .black, location: 1),
                ],
                center: .top,
                startRadius: 10,
                endRadius: 700
            )
            .ignoresSafeArea()
            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Spacer()

                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 12, y: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()
                Text("Score: \(score) / \(countries.count)")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
                Spacer()
            }
            .padding()
        }
        .preferredColorScheme(.dark)
        .alert(scoreTitle, isPresented: $showingScore) {
            if tries < countries.count {
                Button("Continue", action: askQuestion)
            } else {
                Button("Start over", role: .destructive, action: restart)
            }
        } message: {
            if tries < countries.count {
                Text("Your score is \(score)")
            }
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            tries += 1
            if tries < countries.count {
                scoreTitle = "Correct!"
            } else {
                scoreTitle =
                    "Game Over! Your score is \(score) / \(countries.count)."
            }
        } else {
            tries += 1

            if tries < countries.count {
                scoreTitle = "Wrong! That's \(countries[number])"
            } else {
                scoreTitle =
                    "Game Over! Your score is \(score) / \(countries.count)."
            }
        }

        showingScore = true
    }

    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }

    func restart() {
        score = 0
        tries = 0
        print(score)
    }
}

#Preview {
    ContentView()
}
