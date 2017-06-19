# Astralink - [CodeName:DaGithub]
DaGithub - Astralink Assignment project

Introduction
=========================
iOS application that displays the most trending repositories on GitHub that were created in the last day, last week and last month. A user can swipe between views where each view represents a timeframe, and contains a list of reposetories, sorted by the amount of stars.

Architecture
===========================
DaGithub project architecture is consisted of 4 parts :**Api**, **CSI**, **Models**, **User Defaults**
1. **Api** - The Api is base on CRUD design pattern which allow flexible api implementation
2. **CSI** - The CSI (Communication Service Interface) exposes all available api endpoints with smart completion handlers, using FutureKit library.
2. **Model** - The Model layer manages parsing and data reflections
2. **User Defaults Utils** - The User Defaults handles all persisted data. (favorites)

### Implemented Features
for each cell (repository) on the list contains the following information:
* User Avatar
* User login name & Repo Name
* The description for the repository 
* The number of stars 
* infinite scrolling, loading more items when the user reaches the end.
* When a user taps on a cell, presenting a detail screen for the repository with the following information:
    * Language, if available.
    * Number of forks.
    * Creation date.
    * a working link to the GitHub page of the repository.
* User is able to add and remove a repository to and from their own favorite list. The favorites repositories are saved locally and are available even without an internet connection.
* The avatar images are cached by [AlamofireImage](https://github.com/Alamofire/AlamofireImage), in order to avoid redownloading the same images over and over again.
* Universal support for both iPhone and iPad devices
* User has limited access to the reposetories while there's no internet connection.

Missing Features
-----------------------------
* While the APi does support searcing, the UI implementation is not complete.
* iPad and Orientation in general is supported but I wanted to implement custom UI for iPad devices.
* There is only a partial support for offline interaction.