# NYTimes Article Viewer

A simple iOS app that fetches and displays articles from the New York Times API related to elections. The app allows users to stay updated with the latest election-related news articles.

## Features

- Displays a list of articles related to the keyword "election" from the New York Times API.
- Each article card includes:
  - Title
  - Description
  - Publication Date
  - Article Image (if available)
- Supports offline mode: If the network is unavailable, the app loads previously fetched articles from local storage using Core Data.

## Screensh!
[Uploading Simulator Screenshot - iPhone 15 Plus - 2024-04-24 at 14.47.31.png…]()

## Installation

1. Clone the repository to your local machine:
https://github.com/abhishakya8630/KekaAssignment.git 

2. Open the project in Xcode.
3. Build and run the project on a simulator or device.

## Requirements
- Swift 5.0+
- iOS 13.0+

## Usage
1. Launch the app.
2. Articles will be automatically fetched and displayed in the TableView.
3. Tap on an article to view its details.
4. Swipe down to refresh the article list.

## Implementation Details
- Utilizes URLSession to fetch data from the New York Times API.
- Implements Core Data to persist article data locally.
- Follows SOLID principles and protocol-oriented programming for better code maintainability.
- Uses higher-order functions like map and filter for data processing.

## Date Formatting
- Dates are displayed in the format: "25-March-2024".
- Articles are sorted by publication date, with the newest articles appearing at the top.


Feel free to customize this template according to your project's specific details and requirements. Include actual paths to screenshots, icons, and any other assets. Additionally, update the installation instructions with your GitHub repository URL.
