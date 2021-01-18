#  WatchGarageDoor

**Version 1.1.0**

## Garage doors in wrist

With this application, you can conveniently control your garage doors from your wrist.
Made for Apple Watch Series 4 or later with WatchOS 7.0 or later and runs independently without a companion app on iOS.

This application requires you to own a third-party [OpenGarage](http://opengarage.io) controller that is already setup and working in your local Wifi network.
Other controllers are not supported!

### Features

- watchOS 7.0 supported
- Control multiple garage door controllers
- Open and close the selected garage door
- Review status log for open/close actions
- Maintain settings for controllers
- Edit device list of controllers (move or delete)

Please, see the product page at [https://www.mgsoy.com/Products/](https://www.mgsoy.com/Products/)

### Requirements

In order to build this project you will need Xcode 12.0 or later and the Deployment Target must be set to WatchOS 7.0.

### Device Setup

When the device list is empty, you will see "Please, add a device" prompt.
Or you want to add another device, then select Setup on the toolbar to open a setup menu and 
select New device to maintain its parameters (device name, IP address, Port, Device key (only needed for opening and closing), 
number of log entries to show etc.). Once you save the settings, you should see the information about the new device.

If you want to change the device settings, tap the device on the device list to select it and see its status log.
On the status log list, select Options toolbar command to open an options menu for the selected device and select Settings to edit.

### Release Notes

- watchOS 7.0 support added
- New API's Apps and Scenes now utilized
- As Force Touch Context Menus are deprecated on watchOS 7,  the context menus have been changed to toolbar menus.
- Bug fiixes and performance improvements

## License & copyright

© 2020-2021 [Morning Glow Solutions Oy Ltd](https://www.mgsoy.com/Products/)

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
