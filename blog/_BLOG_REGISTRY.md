# RoboWire Blog Registry

This file is maintained automatically by blog/_publish_article.py. Do not
hand-edit the table below except to fix a clear data error.

## Stats
- Total articles: 8
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
| 8 | 2026-07-03 | trajectory-planning-for-robotic-arms | Trajectory Planning for Robotic Arms: From Waypoints to Smooth Motion | trajectory planning for robotic arms, robot trajectory planning, trapezoidal velocity profile, joint space trajectory | Control Systems | Explains trajectory planning for robotic arms: the difference between joint-space and Cartesian-space planning, trapezoidal vs S-curve velocity profiles, quintic polynomial trajectories, multi-joint time synchronization, and a practical checklist for avoiding jerky motion. Links to the PID tuning, inverse kinematics, and harmonic drive vs planetary gearbox articles. |
| 7 | 2026-07-03 | harmonic-drive-vs-planetary-gearbox | Harmonic Drive vs Planetary Gearbox: Choosing the Right Reduction for a Robot Joint | harmonic drive vs planetary gearbox, harmonic drive robotics, planetary gearbox robot arm, strain wave gear | Hardware | Compares harmonic drive (strain wave gear) and planetary gearbox mechanisms for robot joint reduction. Explains the mechanical operating principle and ratio formula for each, then compares backlash (harmonic drives sub-1 arcminute vs planetary 3-15 arcminutes), torsional stiffness (planetary stiffer due to rigid tooth load path vs harmonic drive's flexing thin-wall flexspline), torque density and size (harmonic drive wins per-package due to single-stage high ratio), efficiency (planetary 90-97% vs harmonic drive 65-90% due to flexspline elastic deformation losses), and cost. Ends with selection guidance: harmonic drive for precision/low-backlash joints like arm wrists, planetary for stiffness/high-torque/cost-sensitive joints like wheel hubs and legged robot hips, cycloidal drive as a middle-ground alternative. |
| 6 | 2026-07-03 | slam-basics-for-mobile-robots | SLAM Basics for Mobile Robots: How Robots Map and Localize at the Same Time | SLAM basics for mobile robots, SLAM robotics, simultaneous localization and mapping, SLAM algorithm explained | Software | Explains the SLAM (Simultaneous Localization and Mapping) problem for mobile robots: why pose estimation and map building are coupled, the state representation (robot pose plus landmarks), and the three main algorithm families (EKF-SLAM, particle filter/FastSLAM, graph-based SLAM). Covers loop closure detection and its role in correcting accumulated drift, plus practical considerations around sensor choice, compute budget, map representation, and switching from SLAM to pure localization once a map exists. Links to the Kalman filter article (predict-correct structure shared with EKF-SLAM) and the ROS2 nodes and topics article (graph-based SLAM as used in modern ROS2 stacks). |
| 5 | 2026-07-03 | ros2-nodes-and-topics-explained | ROS2 Nodes and Topics Explained: How Robot Software Talks to Itself | ROS2 nodes and topics explained, ROS2 topics, ROS2 nodes, ROS2 publisher subscriber | Software | Practical explanation of ROS2 nodes and topics: what a node is, how the publish/subscribe model works with working rclpy Python examples (publisher and subscriber for a battery monitor topic), how DDS handles decentralized discovery and QoS (reliable vs best-effort), command-line tools for inspecting a running ROS2 graph (ros2 node list, ros2 topic echo, ros2 topic hz), and when to use topics vs services vs actions. |
| 4 | 2026-07-03 | servo-vs-stepper-vs-bldc-motor-robotics | Servo vs Stepper vs BLDC Motor for Robotics: Choosing the Right Actuator | servo vs stepper vs BLDC motor for robotics, robot actuator selection, stepper motor robotics, BLDC motor robot arm | Hardware | Compares hobby servo motors, stepper motors, and BLDC motors for robotics actuator selection, covering torque density, positional accuracy, control complexity (open-loop vs closed-loop, FOC), cost, and power/driver sizing considerations, with a practical decision framework for picking the right motor per joint. |
| 3 | 2026-07-03 | kalman-filter-robot-state-estimation | Kalman Filter for Robot State Estimation: A Practical Introduction | Kalman filter for robot state estimation, Kalman filter robotics, sensor fusion robot, state estimation robotics | Control Systems | Practical introduction to the Kalman filter for robot state estimation. Explains why fusing a motion model with noisy sensor measurements beats either alone, walks through the predict-update cycle and core equations (state transition F, process noise Q, measurement noise R, Kalman gain K), gives a worked 1D Python-style example, covers tuning guidance for Q and R, and explains when an Extended or Unscented Kalman Filter is needed for nonlinear motion models. Links state estimation output to downstream PID control. |
| 2 | 2026-07-03 | inverse-kinematics-explained | Inverse Kinematics Explained: How Robotic Arms Solve for Joint Angles | inverse kinematics explained, inverse kinematics robotic arm, IK solver robotics, forward vs inverse kinematics | Control Systems | Explains inverse kinematics for robotic arms: contrasts it with forward kinematics, derives a closed-form 2-link planar analytical solution with the law of cosines, covers Jacobian pseudoinverse/damped least-squares iterative solving, and introduces CCD and FABRIK as lightweight alternatives. Includes practical notes on joint limits, singularities, and solution selection. Links to the PID tuning article for the downstream joint control loop. |
| 1 | 2026-07-03 | pid-controller-tuning-for-robotic-arms | PID Controller Tuning for Robotic Arms: A Practical Guide | PID controller tuning for robotic arms, PID tuning robotics, robot joint control, Ziegler-Nichols tuning | Control Systems | Practical guide to PID controller tuning for individual robotic arm joints. Covers the PID formula and discrete implementation, the mechanical role of each term (Kp/Ki/Kd), a manual tuning sequence, the Ziegler-Nichols method with the standard gain table, and fixes for overshoot, steady-state error under load, integral windup, and derivative-driven jitter. Emphasizes tuning per joint rather than per arm due to differing effective inertia. |

## Internal links (article 2)
- inverse-kinematics-explained -> pid-controller-tuning-for-robotic-arms (IK produces target joint angles that a PID position loop then tracks)

## Internal links (article 3)
- kalman-filter-robot-state-estimation -> pid-controller-tuning-for-robotic-arms (state estimate feeds the PID loop's measured value)

## Internal links (article 4)
- servo-vs-stepper-vs-bldc-motor-robotics -> inverse-kinematics-explained (linked stepper joint precision to feeding predictable angles into an IK solver)
- servo-vs-stepper-vs-bldc-motor-robotics -> pid-controller-tuning-for-robotic-arms (linked BLDC FOC velocity/position loops to PID tuning concepts)

## Internal links (article 6)
- slam-basics-for-mobile-robots -> kalman-filter-robot-state-estimation (EKF-SLAM is a direct extension of the Kalman filter predict-correct cycle to a joint pose-and-map state)
- slam-basics-for-mobile-robots -> ros2-nodes-and-topics-explained (graph-based SLAM is the dominant approach in modern ROS2-based robot stacks)

## Internal links (article 7)
- harmonic-drive-vs-planetary-gearbox -> servo-vs-stepper-vs-bldc-motor-robotics (linked from actuator selection context since gearbox choice pairs with motor choice)
- servo-vs-stepper-vs-bldc-motor-robotics -> harmonic-drive-vs-planetary-gearbox (backlink added where gearbox pairing with motor selection is mentioned)

## Internal links (article 8)
- trajectory-planning-for-robotic-arms -> pid-controller-tuning-for-robotic-arms (trajectory discontinuities cause tracking errors that look like PID tuning problems)
- trajectory-planning-for-robotic-arms -> inverse-kinematics-explained (Cartesian trajectories require an IK solver at each timestep)
- trajectory-planning-for-robotic-arms -> harmonic-drive-vs-planetary-gearbox (jerk-limited profiles matter more for backlash-prone gearboxes)
