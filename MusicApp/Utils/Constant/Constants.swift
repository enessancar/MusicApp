//
//  Constants.swift
//  MusicApp
//
//  Created by Enes Sancar on 1.12.2023.
//

import UIKit

struct Constants {
    
    /// Onboard Constant
    enum OnboardPageOne {
        static let color = UIColor.onboardingDarkBackground
        static let title = "Explore Music"
        static let text = "It's time to dive into the world of music! Our app brings you an extensive music catalog. Search for your favorite artists' songs or explore different genres. Find the music you want quickly and start listening right away."
        static let animationName =  "a2"
    }
    
    enum OnboardPageTwo {
        static let color = UIColor.onboardingDarkBackground
        static let title = "Save Your Favorites"
        static let text = "Instantly save the songs that resonate with you! Create your personalized collection of favorite songs. Enjoy revisiting these songs whenever you like."
        static let animationName = "a1"
    }
    
    enum OnboardPageThree {
        static let color = UIColor.onboardingDarkBackground
        static let title = "Personalize Your Experience"
        static let text = "Tailor your music journey! Explore various settings and discover how to make the most out of our app. Customize your listening experience to suit your tastes."
        static let animationName = "a2"
    }
    
    enum Onboarding {
        static let skip = "Skip"
        static let nextButtonImage = "chevron.right.circle.fill"
    }
    
    enum LoginView {
        static let googleTitle = "Sign In with Google"
        static let signIn = "Sign In"
        static let googleImage = "g.circle.fill"
        static let signUp = "Sign Up"
        static let forgotPassword = "Forgot Password ?"
        static let headLabel = "Let's sign in you!"
        static let infoLabel = "Don't have an account?"
    }
    
    enum ForgotPasswordView {
        static let headLabel = "Forgot Password"
        static let sumbit = "Sumbit"
        static let infoLabel = "Already have an account?"
    }
    
    enum HomeView {
        static let discover = "Discover new music"
        static let browse = "Browse"
        static let genres = "Genres"
        static let explore = "Explore"
        static let popularSongs = "Popular Songs"
    }
    
    enum CreatePlaylistView {
        static let title = "Create a New Playlist"
        static let textField = "Playlist name..."
        static let create = "Create"
        static let cancel = "Cancel"
    }
    
    enum PlayerView {
        static let volumeUp = "speaker.wave.2.fill"
        static let volumeDown = "speaker.fill"
        static let forward = "goforward.5"
        static let play = "play.circle.fill"
        static let rewind = "gobackward.5"
        static let heart = "heart"
        static let addToPlaylist = "text.badge.plus"
        static let noSong = "x.circle"
    }
}

enum SFSymbols {
    static let music = "music.note.list"
    static let play = "play.fill"
    static let person = "person.crop.square"
    static let plus = "plus"
    static let createButton = "checkmark.circle"
    static let cancelButton = "x.circle"
}
