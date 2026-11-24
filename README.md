# My Portfolio

My personal portfolio website, built with Flutter Web and deployed on GitHub Pages.

**Live site:** https://ahmedwalied26.github.io/My_Portfolio/

## Features

- Animated hero section with a typing/erasing name effect and an animated portrait frame
- Projects section with real app screenshots presented in phone-frame mockups, with a gallery dialog per project
- Project filtering
- CV download
- Published Flutter package highlight with a pub.dev call-to-action
- Contact section
- Social preview (Open Graph) metadata

## Tech Stack

- **Flutter Web** / Dart
- **UI:** google_fonts, url_launcher, http
- **Deployment:** GitHub Actions to GitHub Pages
- Reduced-motion support: animations fall back to static content when the user prefers reduced motion

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/AhmedWalied26/My_Portfolio.git
   cd My_Portfolio
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run locally:
   ```bash
   flutter run -d chrome
   ```
4. Build for release:
   ```bash
   flutter build web --release
   ```

## Deployment

The site deploys automatically to GitHub Pages via the GitHub Actions workflow in this repository when changes land on the default branch.
