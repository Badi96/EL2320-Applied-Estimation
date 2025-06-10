# EL2320-Applied-Estimation

This repository contains assignments from the course **EL2320 Applied Estimation** at KTH Royal Institute of Technology. Taught by [John Folkesson](https://www.kth.se/profile/johnf), this course focuses on fundamental estimation techniques essential for robotics, navigation, and autonomous systems.

## Course Topics Covered

The course primarily covered the following topics:
* **Kalman Filter**
* **Extended Kalman Filters (EKF)**
* **Particle Filter**
* **Simultaneous Localization and Mapping (SLAM)**
* **Graph SLAM**

---

## Projects & Implementations

This repository includes my implementations for the following exercises:

* **Lab 1: Extended Kalman Filter**
* **Lab 2: Particle Filter**
* **Project: Particle Filter (Image Tracking)**

---

## Final Project: Color-Based Particle Filter for Object Tracking

The final project was chosen to involve implementing a **color-based particle filter** for object tracking. The objective was to track the movement of a ball across a sequence of video frames. Here, we focused on using **RGB color intensity histograms**, where particles were treated as pixels and their color distributions were compared against a reference histogram of the target ball.

Key aspects of the implementation included:
* **Multinomial resampling method** for particle regeneration.
* **Particle weighting** based on the similarity between the reference histogram and the colors of the particles.

While the results were sufficient and demonstrated the core properties of particle filters for object tracking, they also highlighted the limitations of such a color-based approach in complex scenarios.

### Resulting Particle Filter Tracking:

![](./Result.gif)