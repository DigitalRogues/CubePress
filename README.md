# CubePress


CubePress is a Swift project designed to enable iPhone users to interface with their [CUBOTino](https://github.com/AndreaFavero71/CUBOTino_base_version), a small, 3d printable, robot that solves Rubik's cubes in under 90 seconds. CubePress is intended for use in conjunction with the [CUBOTino project](https://github.com/AndreaFavero71/CUBOTino_base_version), and enables users to create a portable version of the CUBOTino by taking photos of their cubes using the camera on a iOS device of their choosing.

The CUBOTino base version is a small, simple, and inexpensive Rubik's cube-solving robot that can be built using the files available in [this repository](https://github.com/AndreaFavero71/CUBOTino_base_version). A PDF file and video tutorial are also provided to guide users through the building process and demonstrate how to present the cube to the camera. CubePress uses a Raspberry Pi Pico instead of an ESP32 board for its WiFi capabilities, allowing the majority of the project's processes to occur on the user's device rather than on the CUBOTino itself. This approach enables the use of a cheaper board for the CUBOTino.

![IMG_8071](https://user-images.githubusercontent.com/37717366/221045957-b61207f2-ea5b-4ae6-8c91-ca06c16dbc81.JPG)

## Features
- Wireless interaction between iphone and CUBOTino via local wifi connection
- New simplified settings menu for callibrating the CUBOTino directly from the phone
- Solution sequence creation using the KociembaSolver library
- Colors interpreted via Apple's Vision Machine Learning API
 
## Getting Started
1. Create a [CUBOTino](https://github.com/AndreaFavero71/CUBOTino_base_version)
2. Create a phone holder for the CUBOTino (TODO)
3. Install all server files to the CUBOTino by going to CubePress/server and installing main.py, server.py, and info.py
4. Install client app onto your iPhone
5. Using cubepress, adjust the CUBOTino's settings
6. Mount your phone in the holder
7. Select "scan cube" and allow the app to use CUBOTino to scan all the sides of the cube
8. Once scanned, select "Solve" to instruct CUBOTino to solve the cube

## Goals
- Tuning of the cubotino via app
- allow users to use their iOS devices to interface with CUBOTino
- uses RESTful api to link devices with CUBOTino via wifi

## Acknowledgments

- [Todd Bates](https://github.com/toddwbates) - Mentor, editor, and over-all great guy
- [Andrea Favero](https://github.com/AndreaFavero71) - Designer of the CUBOTino
- [Sean Garland](https://www.linkedin.com/in/sean-garland/) - UI Consulting

