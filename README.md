# ECS ROS2 Workshop

## Syllabus
1. Control Systems Introduction and Python Simulation. (4 Hours)
2. Design of PID controllers and implementation on STM32 microcontrollers and ROS2. (4 Hours)
3. Introduction to ROS2 and its applications in Control systems. (2 Hours)
4. Setting up the ROS2 and Python environment. (2 Hours)
5. Hands-on session: Building a simple ROS2 node for a control system application. (4 Hours)
6. Hands-on session: Implementing a PID controller with controlsim and ROS2. (4 Hours)
7. Introduction to CMSIS 2 and RTOS for real-time control applications. (4 Hours)
8. Hands-on session: Implementing a PID controller on STM32 microcontrollers using CMSIS 2 and RTOS. (4 Hours)
9. Data publishing and subscribing methods to exchange data between ROS2 and STM32 microcontrollers. (4 Hours)
10. Additional topics: Model-based design, Simulink, and ROS2 integration. (2 Hours)
11. A Project-based learning session where participants will work on a control system project using ROS2 and STM32 microcontrollers. (4 Hours)
12. Q&A and troubleshooting session. (2 Hours)

## ROS2 and Python Environment Setup Instructions
Operating System: Ubuntu 24.04 LTS or Windows WSL with Ubuntu 24.04 LTS
(Note: The setup instructions are tested for Ubuntu 24.04 LTS, but they can also be followed on Windows WSL with Ubuntu 24.04 LTS)

Run the following command in your ubuntu terminal to set up the ROS2 and Python environment for the workshop and follow the prompts. This command will install all the required dependencies for the workshop, including ROS2 Jazzy, Python virtual environment, and other necessary tools.:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/vkbharatv/ECS_ROS2_workshop/main/min_setup.sh)"
```


## STM32CubeMX Installation Instructions
1. Go to the [STM32CubeMX website](https://www.st.com/en/development-tools/stm32cubemx.html) and download the latest version of STM32CubeMX for your operating system.
2. Follow the installation instructions provided on the website to install STM32CubeMX on your computer.
3. After installing STM32CubeMX, you may need to install the necessary toolchains and drivers for your STM32 microcontroller. In this workshop, we will be using the STM32F4 and STM32F7 series. Install the appropriate toolchains and drivers for your specific STM32 microcontroller as needed.

## VSCode Installation Instructions
1. Go to the [Visual Studio Code website](https://code.visualstudio.com/) and download the latest version of Visual Studio Code for your operating system.
2. Follow the installation instructions provided on the website to install Visual Studio Code on your computer.

### STM32CubeMX Extension for VSCode
1. Open Visual Studio Code.
2. Go to the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window or by pressing `Ctrl+Shift+X`.
3. In the search bar, type "STM32Cube" and press Enter.
4. Find the "STM32Cube" extensions in the search results and click on the "Install" button to install it. It will install multiple extensions associated with STM32CubeMX.
5. After the extension is installed, you may be asked to install additional dependencies. Follow the prompts to complete the installation process.

## ROS2 Extension for VSCode (Optional)
1. Open Visual Studio Code.
2. Go to the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window or by pressing `Ctrl+Shift+X`.
3. In the search bar, type "ROS2" and press Enter.
4. Find the "ROS2" extension in the search results and click on the "Install" button to install it.