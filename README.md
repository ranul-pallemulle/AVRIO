This is a collection of libraries and useful programs built using
them, for AVR microcontrollers.

The folder structure is modelled after that of the Nektar++
framework. The library folder contains modules for interfacing with
various pieces of hardware. Projects that can be uploaded to a given
AVR device are available as folders on the root directory. These make
use of the hardware interfaces defined in the library. These projects
are similar to Nektar++ solvers. The CMake build system allows for
easy device configuration. ccmake can be used to specify device
options, programmer options, build options, etc. Building any of the
projects will require the AVR toolchain including avr-gcc, binutils,
etc. Uploading to the device uses AVRdude. One of the goals is to make
the library code, build process and the upload commands completely
device/programmer agnostic by offloading those configurations to the
cmake build system. Another goal is simply to have a collection of
useful programs that can easily be uploaded to any suitable AVR
device. Later, an attempt will be made to implement a device screening
mechanism to check whether the device supports certain technologies
such as I2C or PWM, and warn the user if the user attempts to upload a
program that uses some technology to a device that does not support
it.
