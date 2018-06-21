
Welcome to Kitty application

1. The service used to get the images is " http://thecatapi.com/api/images/get?api_key=MzIyOTkx&format=xml&type=png&size=small&results_per_page=100"

5. I have framed my own 2 stage cache mechanism to store the images locally

6. NSCache is used to store images in local Cache to ensure smooth user interaction, This will automatically clear the data if it exceeds the limit

7. Documents directory is used to store favorite images, This way, we have avoided fetching data from favorites API 

8. I have implemented my own XML parsing mechanism with the help of default Apple's XML framework

9. I have created my own assets for this application

10. I have tested the application in iPhone7 and later (iPhone8, 8+, iPhoneX)

Here are some of the application build specifications
I. SDK: Xcode vesrion 9.4
II. Traget OS version: iOS 11.x
III. Supported device types: iPhone
IV. Supported orientations: Portrait
