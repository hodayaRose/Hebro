//
//  SpeachFeature.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/3/23.
//

import SwiftUI
import AVFoundation
//uses voiceover to use a synthetic voice and pronounce a randome letter from array
struct SpeachFeature: View {
    let synthesizer = AVSpeechSynthesizer()
    let hebrewLetters = ["א", "ב", "ג", "ד", "ה", "ו", "ז", "ח", "ט", "י", "כ", "ל","מ", "נ", "ס", "ע", "פ", "צ", "ק", "ר", "ש","ת"]
    let wordSelected = ["Guitar":"גיטרה","Shoe":"נעל","Robot":"רובוט"]
    
    
    func pronunciationOf(_ letter: String) {
        if AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Carmit-compact") != nil {
            let utterance = AVSpeechUtterance(string: letter)
            utterance.voice = AVSpeechSynthesisVoice(language: "he-IL")
            // Adjust these properties to make the speech sound more natural
            utterance.rate = 0.2// Speed of speech, on a scale from 0.0 (slowest) to 1.0 (fastest)
            utterance.pitchMultiplier = 1// Pitch, on a scale from 0.5 (lowest) to 2.0 (highest)
            utterance.volume = 0.8  // Volume, on a scale from 0.0 (silent) to 1.0 (loudest)
            utterance.postUtteranceDelay = 2// Delay (in seconds) before the next utterance begins
            
            synthesizer.speak(utterance)
        }
    }
    func pronunciationOfWord(_ word: String) {
        if let hebrewWord = wordSelected[word] ,AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.he-IL.Carmit") != nil{
            let hebrewVoices = AVSpeechSynthesisVoice.speechVoices().filter { $0.language == "he-IL" }
            for voice in hebrewVoices {
                print(voice.name, voice.identifier)
            }
            let utterance = AVSpeechUtterance(string: hebrewWord)
            utterance.voice = AVSpeechSynthesisVoice(language: "he-IL")
            utterance.rate = 0.3
            utterance.pitchMultiplier = 1.3
            utterance.volume = 0.8
            utterance.postUtteranceDelay = 2
            synthesizer.speak(utterance)
        }else{print("voice over not detected")}
    }
    
    var body: some View {
        Button(action: {
            
            // Find the phonetic pronunciation of the letter
            pronunciationOf(hebrewLetters.randomElement()!)
        }
               
        )
        { Text("Press me to hear Siri speak!")}
    }
}
#if DEBUG
struct SpeachFeature_Previews: PreviewProvider {
    static var previews: some View {
        SpeachFeature()
    }
}
#endif


