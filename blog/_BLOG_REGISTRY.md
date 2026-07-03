# RoboWire Blog Registry

This file is maintained automatically by blog/_publish_article.py. Do not
hand-edit the table below except to fix a clear data error.

## Stats
- Total articles: 3
- Last published: 2026-07-03

## Keyword Pool (not yet used)
- PID controller tuning for robotic arms
- inverse kinematics explained
- Kalman filter for robot state estimation
- ROS2 nodes and topics explained
- servo vs stepper vs BLDC motor for robotics
- SLAM basics for mobile robots
- choosing a battery for a quadruped robot
- harmonic drive vs planetary gearbox
- trajectory planning for robotic arms
- IMU sensor fusion basics
- simulating robots in Gazebo vs PyBullet
- encoder wiring for a 6-DOF arm
- real-time considerations in robot control loops
- feedback control basics for beginners
- power budgeting for mobile robots

## Article Table
| # | Date | Slug | Title | Keywords | Tag | Summary |
|---|------|------|-------|----------|-----|---------|
| 3 | 2026-07-03 | kalman-filter-robot-state-estimation | Kalman Filter for Robot State Estimation: A Practical Introduction | Kalman filter for robot state estimation, Kalman filter robotics, sensor fusion robot, state estimation robotics | Control Systems | Practical introduction to the Kalman filter for robot state estimation. Explains why fusing a motion model with noisy sensor measurements beats either alone, walks through the predict-update cycle and core equations (state transition F, process noise Q, measurement noise R, Kalman gain K), gives a worked 1D Python-style example, covers tuning guidance for Q and R, and explains when an Extended or Unscented Kalman Filter is needed for nonlinear motion models. Links state estimation output to downstream PID control. |
| 2 | 2026-07-03 | inverse-kinematics-explained | Inverse Kinematics Explained: How Robotic Arms Solve for Joint Angles | inverse kinematics explained, inverse kinematics robotic arm, IK solver robotics, forward vs inverse kinematics | Control Systems | Explains inverse kinematics for robotic arms: contrasts it with forward kinematics, derives a closed-form 2-link planar analytical solution with the law of cosines, covers Jacobian pseudoinverse/damped least-squares iterative solving, and introduces CCD and FABRIK as lightweight alternatives. Includes practical notes on joint limits, singularities, and solution selection. Links to the PID tuning article for the downstream joint control loop. |
| 1 | 2026-07-03 | pid-controller-tuning-for-robotic-arms | PID Controller Tuning for Robotic Arms: A Practical Guide | PID controller tuning for robotic arms, PID tuning robotics, robot joint control, Ziegler-Nichols tuning | Control Systems | Practical guide to PID controller tuning for individual robotic arm joints. Covers the PID formula and discrete implementation, the mechanical role of each term (Kp/Ki/Kd), a manual tuning sequence, the Ziegler-Nichols method with the standard gain table, and fixes for overshoot, steady-state error under load, integral windup, and derivative-driven jitter. Emphasizes tuning per joint rather than per arm due to differing effective inertia. |

## Internal links (article 2)
- inverse-kinematics-explained -> pid-controller-tuning-for-robotic-arms (IK produces target joint angles that a PID position loop then tracks)

## Internal links (article 3)
- kalman-filter-robot-state-estimation -> pid-controller-tuning-for-robotic-arms (state estimate feeds the PID loop's measured value)
