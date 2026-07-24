# SEO Research & Strategy Log

This file is written by the autonomous blog agent. Append only - do not rewrite
history. Keep entries short (max 5 bullets). The compact context file surfaces
only the most recent entries, so older ones matter less over time - that's fine.

## Research Entries

### 2026-07-23 (2)
- Candidates checked: Kalman filter for robot state estimation, inverse kinematics explained, PID controller tuning for robotic arms (all three already published under existing slugs despite still appearing in the stale "not yet used" keyword pool list), Denavit-Hartenberg parameters worked example (reconfirmed saturated, automaticaddison.com already has a very thorough "Ultimate Guide"-style frame-assignment walkthrough), cascaded PID control loop tuning for robot joints.
- Chose "Cascaded PID Control for Robot Joints: A Worked Bandwidth-Separation Example": Synapticon docs, SimpleFOC docs and a couple of vendor knowledgebase pages describe the position-over-velocity-over-current loop structure and the qualitative "tune inner loop first, keep loops 5-10x apart in bandwidth" rule, but none show it as a worked numeric example.
- Weakness in current top pages: no page starts from real motor/mechanical numbers (R, L, J, b) and actually derives PI gains for all three nested loops from a chosen bandwidth ratio, or explains what breaks (position loop oscillates, or feels sluggish/laggy) when the bandwidth separation rule is violated.

### 2026-07-21
- Candidates checked: sliding mode control for robot arms (backup candidate, only academic papers and IEEE/ScienceDirect abstracts, no accessible hobbyist worked example, gap still confirmed but scoping the chattering/boundary-layer math tightly enough for 800-1300 words is risky this cycle), cycloidal drive gearboxes (Firgelli and patsnap already give the L/(P-L) ratio formula and a general explanation, moderate overlap risk with the published harmonic-drive-vs-planetary-gearbox article), ball screw vs lead screw actuator sizing (still generic industrial-catalog level, confirmed again as backup only), NVIDIA Isaac Sim getting started (official NVIDIA docs and DLI course already cover a full step-by-step first-robot tutorial thoroughly, saturated for the generic angle), robot arm TCP (tool center point) pivot calibration.
- Chose "Tool Center Point (TCP) Pivot Calibration: A Worked Least-Squares Example": PickNik MoveIt Pro docs, control.com, and Hirebotics all describe the standard "teach 3-4 poses around a fixed point" procedure conceptually and say software "calculates" the offset, but none show the actual linear algebra.
- Weakness in current top pages: no page walks through setting up the least-squares system from multiple recorded end-effector poses (rotation matrices plus translation vectors) and solving for the actual TCP offset vector, or explains the common failure symptom (tool tip appears to swing in a cone during pure reorientation moves) that tells a builder their TCP offset is wrong.

### 2026-07-20 (2)
- Candidates checked: Denavit-Hartenberg parameters worked example (still saturated per repeated prior entries, confirmed again), PID anti-windup/actuator saturation for robot arms (arXiv papers and a Simulink/Medium writeup already explain clamping vs back-calculation clearly at a generic-control-theory level), ball screw vs lead screw actuator sizing (still generic industrial-catalog level per 2026-07-20 strategy note, viable backup), RS-485/Modbus wiring for robot joint networks.
- Chose "RS-485/Modbus for robot joint networks: wiring, addressing, and polling-rate budget": top pages (Schneider Electric, Ozeki, Measurlogic, electrical-engineering-portal) cover generic RS-485 cabling rules (twisted pair, 120-ohm termination, A/B polarity, 32-device limit) for building-automation contexts, not robot joints.
- Weakness in current top pages: none show the actual arithmetic of how Modbus RTU frame time at a given baud rate, plus per-slave turnaround delay, combines with the number of daisy-chained joint drivers to determine the achievable polling rate - builders get wiring rules but no way to check whether N joints at a given baud rate can hit their control loop's update rate, the same gap the CAN bus and EtherCAT articles already closed for those protocols.

### 2026-07-20
- Candidates checked: RRT path planning for robot arms (still stuck in academic RRT*/DAPF-RRT papers with no hobbyist worked example, confirmed gap-too-thin again per prior entries), ROS2 actions vs services vs topics (well covered by official ROS2 docs, The Construct, Foxglove, automaticaddison - saturated), Denavit-Hartenberg parameters (still saturated, confirmed again), Madgwick filter IMU orientation (AHRS docs, several Medium/PDF writeups already explain the algorithm and quaternion math clearly), zero moment point (ZMP) for legged robot balance.
- Chose "zero moment point (ZMP) for legged robot balance, worked numeric example": top pages are patents, IEEE/arXiv papers, and a Dutch thesis PDF that define ZMP formally and discuss control schemes, with nothing scoped to a hobbyist quadruped/biped builder.
- Weakness in current top pages: none walk through computing the actual ZMP location (from CoM position, acceleration, and height using the standard x_zmp = x_com - (z_com/g)*x_com_ddot formula) for a simple robot stance with real mass/height/acceleration numbers, then checking it against the support polygon to tell a builder whether their gait phase is stable or about to tip.

### 2026-07-19 (2)
- Candidates checked: series elastic actuator (SEA) design for robot joints, DH-parameter kinematic calibration (still flagged gap-too-thin in repeated prior entries, confirmed saturated again), quaternion vs Euler angle gimbal lock (Wikipedia, CH Robotics, and several 2026 blog posts already explain this clearly, saturated), current-sense shunt resistor sizing for motor drivers (DigiKey/NXP cover the generic electronics case well), ROS2 lifecycle nodes (official design doc, Foxglove, and Medium walkthroughs already cover the state machine well).
- Chose "series elastic actuator (SEA) spring stiffness sizing for a robot joint": top pages (IntechOpen chapter, ResearchGate papers, a robotis forum PDF) explain the concept - compliance, impact tolerance, force control benefit - at a research/academic level, and a YouTube video shows a build but skips the math.
- Weakness in current top pages: none walk through picking an actual torsional spring stiffness (Nm/rad) for a specific joint given the desired force-control bandwidth and expected peak torque, or show the resulting deflection-to-torque calibration a builder needs to read torque from a position sensor across the spring - it stays at "add a spring in series" without the numbers.

### 2026-07-19
- Candidates checked: robot arm homing sequence with limit switches (source-robotics blog and PAROL6 docs already cover the sequence reasonably well, viable backup), ROS2 actions vs services (well covered by ROS2 official docs, The Construct, Foxglove), quaternion vs Euler angle gimbal lock for robot orientation (Wikipedia, CH Robotics, and a few blogs explain the concept clearly already), sensorless BLDC motor commutation via back-EMF zero-crossing.
- Chose "sensorless BLDC motor commutation, back-EMF zero-crossing timing": top pages (mechtex, DigiKey, NXP app note, Infineon forum) explain the zero-crossing concept and the 30-degree phase lag qualitatively, but stay at block-diagram level.
- Weakness in current top pages: none work through an actual numeric commutation timing example (electrical period at a given RPM/pole-pair count, the resulting 30-degree phase-lag delay in microseconds, and how that delay must be recalculated as speed changes) or connect it to the PWM demagnetization/blanking time that corrupts zero-crossing detection at low duty cycle - builders get "detect the zero crossing, wait 30 degrees" without the actual math or the low-speed failure mode.

### 2026-07-18
- Candidates checked: Denavit-Hartenberg parameters (still saturated per prior entries), H-bridge PWM current limiting/chopping (same broad H-bridge/PWM topic flagged saturated on 2026-07-15), RRT vs A* path planning for mobile robots (multiple academic comparison papers already cover it well), ROS2 tf2 transforms (already well covered, confirmed again), emergency stop (E-stop) circuit design for a robot arm.
- RRT vs A* and DH parameters: confirmed still gap-too-thin, skipped again.
- Chose "emergency stop (E-stop) circuit design for a robot arm, Category 3 dual-channel wiring": top pages are either generic industrial-safety-relay vendor blogs (Industrial Monitor Direct, PLC ladder-logic guides) written for factory conveyor/press contexts, or academic-safety-standard summaries, with nothing scoped to a hobbyist/small robot-arm builder wiring their own dual-channel E-stop into a motor driver enable line.
- Weakness in current top pages: none show a builder how to wire a dual-channel Category 3 E-stop loop into a small robot arm's driver enable/STO pins with real component numbers, how to size the cross-fault detection, or how to budget the stop-response time against the arm's worst-case joint velocity.

### 2026-07-17
- Candidates checked: Denavit-Hartenberg parameters (forward kinematics), sliding mode control for robot arms, joint friction compensation (Coulomb/viscous/Stribeck), strain-gauge force/torque sensors for grippers, RRT path planning for robot arms.
- DH parameters: still gap-too-thin, confirmed already thoroughly covered (see 2026-07-16 entry).
- Sliding mode control and RRT for robot arms: both stay locked in MATLAB/Simulink examples or academic papers (IntechOpen, MathWorks, IEEE) with no hobbyist-scale worked numbers - kept sliding mode as a backup candidate, RRT already has a decent hobbyist writeup (fusybots.com) so gap is thinner there.
- Chose "Coulomb and viscous friction compensation for robot arm joints": top pages (ResearchGate friction-compensation overviews, IET papers, a KUKA-specific Wiley study) stay in symbolic model-identification language or are locked to a specific industrial robot, and MathWorks' example requires Simulink System Identification.
- Weakness in current top pages: none show a builder how to actually estimate Coulomb + viscous coefficients from a simple constant-velocity test on their own joint, then add the feedforward friction term to an existing PD/PID loop with real torque numbers - and none connect the fix to the concrete symptom (stick-slip jitter and dead zone near zero velocity) that tells a builder they are missing it.

### 2026-07-11
- Candidates checked: Gazebo vs PyBullet simulation choice, feedback control basics for beginners, URDF explained for a robot arm, A* vs RRT path planning, stepper motor microstepping and torque.
- Gazebo vs PyBullet: still saturated - godrift.ai, blackcoffeerobotics.com and roboticscenter.ai already published detailed 2026 ROS2-integration comparisons.
- URDF and A* vs RRT: both have solid existing worked-example coverage (articulatedrobotics.xyz/automaticaddison.com for URDF; multiple comparison papers and Medium RRT* code walkthroughs for path planning) - gap too thin for a fresh piece right now.
- Chose "stepper motor microstepping explained for robotics": top pages (Analog Devices, Faulhaber, mechtex, linearmotiontips) explain the concept and the torque-per-microstep tradeoff correctly but from a generic industrial-motion-control angle, with no worked numbers for a small robot joint, no driver-chip specifics (A4988 vs DRV8825 vs TMC2209), and no missed-step/lost-position failure scenario tied back to closed-loop correction.
- Weakness in current top pages: none derive the holding-torque-per-microstep formula with actual numbers for a hobby-robot NEMA motor, and none connect microstepping resolution choice to real step-loss risk under load.

### 2026-07-15
- Candidates checked: ROS2 TF2 transforms explained, real-time considerations in robot control loops, absolute vs incremental encoder choice, H-bridge PWM brushed DC motor driver, robot arm homing sequence with limit switches.
- TF2 and H-bridge PWM: both already well covered with hands-on, code-backed tutorials (articulatedrobotics.xyz/docs.ros.org for TF2; Instructables/DroneBot Workshop/HowToMechatronics for H-bridge PWM) - gap too thin.
- Absolute vs incremental encoders: decent vendor comparison tables exist (US Digital, Hobber Drive) but no worked example - kept as a backup candidate for a future cycle.
- Chose "real-time considerations in robot control loops": top pages are either academic PDFs (ResearchGate jitter studies) or vendor blog posts (BlackBerry QNX) that stay conceptual - no page walks through picking a concrete loop rate, measuring jitter with real timer code, and showing how much jitter a PD gain margin can tolerate before oscillation.

### 2026-07-15b
- Candidates checked: computed torque control for robot arms, impedance vs admittance control, Monte Carlo localization (particle filter), absolute vs incremental encoders, ROS2 actions vs services vs topics.
- MCL/particle filter and ROS2 actions/services/topics: both already have solid, well-structured coverage (official ROS2 docs, automaticaddison.com, roboticsknowledgebase.com) with clear conceptual breakdowns - gap too thin for a fresh piece.
- Impedance vs admittance control: decent conceptual comparisons exist (source-robotics, patsnap) but none show a worked numeric example - kept as a backup candidate for a future cycle.
- Chose "computed torque control for robot arms": top pages are either the Wikipedia stub, IEEE/NASA papers, or a single ping-pong-robot case study (mecharithm) - all stay in symbolic matrix notation or skip straight to a specific research application, none show a full numeric feedback-linearization computation for a simple two-link arm with real inertia/gravity terms.
- Weakness in current top pages: none connect computed torque control back to the simpler PD-with-gravity-feedforward approach already covered on this site, or show the actual matrix arithmetic (M(q), C(q,qdot), G(q)) reducing tracking error dynamics to a simple double integrator with real numbers.
- Weakness in current top pages: none show a concrete C/pseudo-code fixed-rate loop with clock_gettime-style timing, an actual jitter budget calculation, or the link between missed real-time deadlines and a specific control-loop symptom (torque spikes, instability at high gain).

### 2026-07-16
- Candidates checked: impedance control for robot arms, Denavit-Hartenberg parameters explained, ROS2 actions vs services vs topics, CAN bus for robot joint networks, sliding mode control for robot arms.
- DH parameters and ROS2 actions/services/topics: both already have thorough, well-structured coverage (automaticaddison.com, universal-robots.com for DH; official ROS2 docs and automaticaddison for actions/services) - gap too thin.
- Impedance control and sliding mode control: solid backup candidates (impedance control has decent conceptual writeups but no worked numeric example; sliding mode stays in academic/Simulink papers) - kept for a future cycle.
- Chose "CAN bus for robot joint networks": top pages (thinkrobotics.com, WPILib docs, robotsforroboticists.com) explain CAN's benefits and wiring in general terms, but WPILib's guide is FRC-specific and the others skip the actual bit-timing and bus-load arithmetic a builder needs for their own joint network.
- Weakness in current top pages: none show a worked bit-timing calculation (propagation delay vs bus length at a given baud rate) or a concrete bus-load percentage for a multi-joint arm's status messages, and none tie termination-resistor placement to a specific reflection/error-frame symptom.

### 2026-07-16b
- Candidates checked: impedance control vs admittance control for robot arms, absolute vs incremental encoder choice, ROS2 actions vs services vs topics, H-bridge PWM brushed DC motor driver.
- ROS2 actions/services/topics and H-bridge PWM: both already have thorough, code-backed coverage (official ROS2 docs, automaticaddison.com for actions/services; Instructables/HowToMechatronics for H-bridge PWM) - gap too thin.
- Absolute vs incremental encoders: decent vendor comparison tables (US Digital, Hobber Drive) but still no worked example - kept as a backup candidate again.
- Chose "impedance control vs admittance control for robot arms": this topic has now shown the same gap across three research cycles (2026-07-15b, 2026-07-16, today) - top pages (source-robotics, patsnap, academic ROBOMECH/ICRA papers) explain the force-vs-motion conceptual distinction correctly but every one stays in symbolic notation or skips to a specific research application.
- Weakness in current top pages: none show a worked numeric mass-spring-damper computation (actual K, D, M values) for a simple one-DOF arm contact scenario comparing what an impedance controller commands vs what an admittance controller commands for the same measured force, and none connect the choice back to a concrete failure symptom (impedance control degraded by friction vs admittance control going unstable against a rigid stop).

(No entries yet. Each cycle, before choosing a topic, add one dated entry here:
candidate topics considered, the one chosen and why - demand signal plus the
content-quality edge over what currently ranks - and one weakness noticed in
the current top-ranking pages for that query.)

### 2026-07-07
- Candidates checked: real-time considerations in robot control loops, Gazebo vs PyBullet simulation choice, encoder wiring for a 6-DOF arm.
- Real-time control loops: decent existing coverage (one strong independent blog, forum threads, patents) - gap is smaller than expected.
- Gazebo vs PyBullet: already well covered by roboticsknowledgebase.com and academic comparison papers - saturated for a first-pass explainer.
- Chose "quadrature encoder wiring for a 6-DOF robot arm": top-ranking pages are hobby-servo tutorials (potentiometer-based RC servos or generic single-motor Arduino rotary encoder demos), none walk through real quadrature decoding math, CPR-to-angle conversion after a gear ratio, or index-pulse homing for a full 6-axis arm using real encoder-equipped DC/BLDC motors.
- Weakness in current top pages: they conflate hobby servos (no real encoder feedback) with actual encoder-based joint control, and skip the interrupt/timer-based decoding code entirely.

### 2026-07-07 (2)
- Candidates checked: power budgeting for mobile robots, feedback control basics for beginners, real-time considerations in robot control loops, simulating robots in Gazebo vs PyBullet.
- Real-time control loops and Gazebo vs PyBullet: already flagged in the previous entry as weak-gap/saturated, confirmed still true, skipped again.
- Feedback control basics for beginners: mostly generic corporate-blog explainers (numberanalytics, vaia, LinkedIn advice posts) restating open-loop-vs-closed-loop at a very high level with no math; risk of conceptual overlap with our own published PID article outweighs the gap.
- Chose "power budgeting for mobile robots": top pages (techietory.com, iBuyRobotics, Articulated Robotics) explain the general "list components, add margin" idea but stop short of a worked peak-vs-average current table, wire gauge/fusing sizing from that table, and brownout risk from motor stall current on a shared rail.
- Weakness in current top pages: none of them separate peak (stall/inrush) current from average current in a worked numeric example, and none connect the resulting current budget to wire gauge ampacity or fuse/breaker sizing.

### 2026-07-10
- Candidates checked: differential drive robot kinematics/odometry, URDF robot description tutorials, robot joint torque control via current sensing, real-time considerations in robot control loops (re-checked).
- Differential drive odometry: saturated - WPILib, automaticaddison.com, Zbotic and Bench Robotics all already give full worked equations and Python code.
- URDF tutorials: saturated and documentation-shaped - Articulated Robotics and MoveIt docs already cover structure, xacro, and common mistakes thoroughly.
- Real-time control loops: re-confirmed still a thin gap as noted on 2026-07-07, skipped again.
- Chose "torque control for robot arm joints via current sensing": top results are dense patents (USPTO current-limiting/torque-limiting filings) and academic sliding-mode/flexible-joint papers; nothing accessible walks through the Kt-based torque-from-current relationship, a cascaded current/velocity/position loop structure, or a concrete PI current-loop tuning example with real numbers for a small robot arm joint.
- Weakness in current top pages: they either patent-describe current limiting abstractly or bury the current-loop math inside advanced sliding-mode papers, leaving a builder with a current sensor no practical path from measured current to a tuned, safe torque command.

### 2026-07-08
- Candidates checked: incremental vs absolute encoders, motor driver current sensing (shunt sizing), choosing a microcontroller for real-time robot control, LQR control for robot arms vs PID.
- Incremental vs absolute encoders: well covered by multiple vendor comparison pages (Heidenhain, Celera Motion, ELTRA); mostly product-marketing framing, but the core comparison itself is not underserved.
- Motor driver current sensing / shunt sizing: coverage is fragmented across patents and generic app notes (Allegro), no robotics-specific worked example, but overlaps somewhat with the already-published power budgeting article.
- Choosing a microcontroller for real-time robot control: only thin forum threads (electro-tech-online, etechnophiles), decent gap but mostly a listicle-shaped topic (STM32 vs Teensy vs ESP32) that risks becoming generic buying advice rather than technical depth.
- Chose "LQR control for robot arms vs PID": top results are paywalled IEEE/ResearchGate papers or a self-balancing-robot blog post; none give an accessible worked state-space example (A/B matrices for a simple joint, Q/R cost tuning walkthrough, closed-loop pole comparison against a tuned PID) for someone who already knows PID from our existing article.

### 2026-07-10 (2)
- Candidates checked: real-time considerations in robot control loops (re-checked), impedance control for robot arms, robot arm force/compliant control, ROS2 executors and callback groups.
- Real-time control loops: still weak-gap per the deprioritization on 2026-07-10, skipped again.
- Impedance control: GitHub tutorials (franklinselva, mathworks) and source-robotics already give a decent conceptual + code walkthrough; gap smaller than expected.
- Compliant/force control for end effectors: coverage is either medical-research papers (nasopharyngeal swab study) or vendor compliance-tool product pages, not a robotics-hobbyist angle, but scope felt closer to a hardware buying guide than a control-systems explainer.
- Chose "ROS2 executors and callback groups explained": top pages are the official ROS2 docs (dense reference style, no concrete failure scenario), a ROS Answers thread, and one Medium series; none walk through a worked example of a slow sensor callback blocking a control loop in the same mutually-exclusive callback group, with a timing diagram and the reentrant-group fix in code.
- Weakness in current top pages: they define executors and callback group types correctly but never show the concrete bug (one slow callback stalling everything else in its group) that makes a robotics developer actually need this concept.

### 2026-07-14
- Candidates checked: robot arm gravity compensation (feedforward), Gazebo vs PyBullet simulation choice, URDF explained, PID vs state-space feedback control basics.
- Gazebo vs PyBullet: reconfirmed saturated again (2026-07-07, 2026-07-11, 2026-07-12, 2026-07-13), skipped.
- URDF explained: well covered already by articulatedrobotics.xyz, the official ROS2 docs, and several step-by-step blog tutorials with clear link/joint breakdowns - gap too thin.
- PID vs state-space feedback control basics: overlaps heavily with the existing PID tuning and LQR articles, and top pages (motioncontroltips, WPILib docs, a Medium piece) already explain the conceptual difference reasonably well.
- Chose "robot arm gravity compensation": top pages are either research papers (iterative learning schemes, ARMin feedforward study) too abstract for a hobbyist, or short vendor/product overviews (source-robotics, phospho.ai) that state the concept and the general inverse-dynamics idea but never show a worked numeric torque computation for a concrete link.
- Weakness in current top pages: none walk through computing the actual gravity torque (tau = m * g * l * cos(theta)) for a simple one- or two-link arm with real mass/length numbers, layered under a PD position loop, and none mention the common symptom (arm sags or oscillates without gravity feedforward) that tells a builder they're missing this term.

## Strategy Adjustments

### 2026-07-22
- Rebalanced back after the cluster-1 push: added one line to
  blog/_BLOG_STRATEGY.md Topic Priority deprioritizing further cluster 1
  picks for a few cycles. Basis: the 2026-07-21 audit favored cluster 1, and
  articles 41-46 then came out 5 of 6 Control Systems (TCP calibration,
  sliding mode, encoder velocity estimation, mecanum kinematics, PID
  anti-windup), inverting the imbalance the 2026-07-21 audit was correcting.
  Meanwhile research entries kept confirming hardware-side gaps that were
  never picked: DC motor parameter identification (2026-07-22b, 2026-07-22c)
  and H-bridge deadtime (2026-07-18, 2026-07-18b, 2026-07-19). Favor
  non-networking cluster 2 and cluster 4 worked-numeric angles next.

### 2026-07-21
- Deprioritized the "joint network protocol" angle within cluster 2 in
  blog/_BLOG_STRATEGY.md Topic Priority. Reviewed the last 10 published
  articles (31-40): three of them in a row picked a joint network protocol
  (CAN bus 2026-07-16, EtherCAT 2026-07-20, RS-485/Modbus 2026-07-20(2)),
  covering the three fieldbuses actually used in robot joint networks -
  further picks in this specific angle now risk self-saturation rather than
  finding a real external gap. The same 10-article window also showed
  cluster 2/Hardware at 5 of 10 and cluster 1/Control Systems at only 1 of
  10 (ZMP), a reversal from the 2026-07-19 audit's balance (5 Control, 4
  Hardware). Rebalanced the priority list to favor cluster 1 for the next
  several cycles, with sliding mode control noted as the current backup
  candidate (2026-07-21 research entry).

### 2026-07-19
- No change - reviewed the last 10 published articles (26-35) and all research
  entries since the last audit. The already-retired topics (Gazebo vs
  PyBullet, DH parameters, ROS2 actions vs services, feedback control basics)
  were reconfirmed saturated again this cycle (quaternion vs Euler/gimbal
  lock also newly checked and found saturated) with no new pattern beyond
  what the current Topic Priority list already reflects. Hardware and
  Control Systems clusters keep finding strong worked-numeric-example gaps
  (5 of the last 10 articles were Control Systems, 4 were Hardware, only 1
  was Software), consistent with the existing guidance to favor those
  clusters over generic ROS2/software conceptual topics - not a new finding,
  just a continued confirmation, so no edit made.

### 2026-07-17b
- Retired "Denavit-Hartenberg parameters" entirely from blog/_BLOG_STRATEGY.md
  Topic Priority (cluster 1), based on 4 separate research entries
  (2026-07-12, 2026-07-13(2), 2026-07-16, 2026-07-17) all independently
  re-checking it and finding it saturated every single time
  (automaticaddison.com, Robot Academy, universal-robots.com) - further
  rechecks are wasted research effort, same pattern as the earlier
  Gazebo/PyBullet retirement. Noted sliding mode control for robot arms as
  the current best backup candidate for cluster 1 (checked twice, 2026-07-16
  and 2026-07-17, both times finding a real but MATLAB/Simulink-locked gap).

### 2026-07-17c
- Retired "ROS2 actions vs services vs topics" entirely from
  blog/_BLOG_STRATEGY.md Topic Priority (cluster 3), based on 3 separate
  research entries (2026-07-12, 2026-07-17, 2026-07-17b) all independently
  re-checking it and finding it saturated every time (docs.ros.org,
  automaticaddison.com, The Construct) - same pattern as the DH parameters
  and Gazebo/PyBullet retirements. Noted series elastic actuators as the
  current best backup candidate for a hardware/hobbyist worked-numeric gap
  (2026-07-17b), pending a tightly-scoped spring-stiffness example.

### 2026-07-15c
- Retired "Gazebo vs PyBullet" entirely from blog/_BLOG_STRATEGY.md Topic
  Priority (cluster 3) instead of just deprioritizing it, based on 8 separate
  research entries (2026-07-07, 2026-07-07(2), 2026-07-09, 2026-07-11,
  2026-07-12, 2026-07-12(2), 2026-07-13, 2026-07-14) all independently
  re-checking it and finding it saturated every single time - further
  rechecks are wasted research effort. Also removed the now-stale
  deprioritization of "real-time considerations in robot control loops"
  since it was eventually found to have a real gap and published as
  article 25 on 2026-07-15.

(No entries yet. Roughly every 5 published articles, review the research
entries above and decide whether blog/_BLOG_STRATEGY.md's "Topic Priority"
section still reflects reality. Log either the change made and why, or
"no change needed" and why, as a single dated line.)

### 2026-07-12
- Deprioritized "feedback control basics for beginners" within cluster 1 in
  blog/_BLOG_STRATEGY.md Topic Priority. It was checked and rejected three
  separate times (2026-07-07(2), 2026-07-11, 2026-07-12), always for the
  same reason: thin generic source coverage plus conceptual overlap with the
  existing PID tuning article. Also noted that "real ROS2 middleware
  internals" within cluster 3 has now found a strong concrete gap twice in a
  row (executors/callback groups on 2026-07-10(2), QoS settings on
  2026-07-12), reinforcing the existing preference for that angle.

### 2026-07-10
- Deprioritized "real-time considerations in robot control loops", "URDF
  tutorials", and "Gazebo vs PyBullet" within cluster 3 in
  blog/_BLOG_STRATEGY.md Topic Priority, based on the 2026-07-07,
  2026-07-07(2), 2026-07-09, and 2026-07-10 research entries all
  independently re-checking these three topics and finding weak gap or
  saturated existing coverage every single time.

### 2026-07-09
- Candidates checked: brushless motor FOC vs trapezoidal commutation, gearbox backlash compensation for robot arms, URDF description common mistakes, real-time considerations in robot control loops (re-checked).
- FOC vs trapezoidal: reasonably well covered by TI app notes and vendor explainers (vector-robotics, ISL Products) with clear tradeoffs already public.
- URDF common mistakes: well served by ROS2 official docs, MoveIt docs, and Articulated Robotics tutorials; low gap for a first-pass explainer.
- Real-time control loops: still weak-gap per the 2026-07-07 entries, skipped again.

### 2026-07-09 (2)
- Candidates checked: impedance vs admittance control for robot arms, robot arm singularity avoidance with the Jacobian, CAN bus vs RS485 for robot communication.
- Impedance vs admittance control: decent conceptual coverage already exists (source-robotics, patsnap articles explain the force/motion distinction clearly), gap is smaller than expected for a first-pass explainer.
- CAN bus vs RS485: well covered by multiple vendor/industrial comparison pages (dnkpower, dorleco, robotmotor), mostly generic electrical-protocol framing not specific to arms.
- Chose "robot arm singularity avoidance with the Jacobian": top-ranking pages are either dense academic papers/patents (arXiv, MDPI, USPTO) or short vendor blog posts (RoboDK, Realman) that name the concept and the damped-least-squares idea but do not walk through a worked numeric example - computing the Jacobian determinant for a simple planar arm, showing it approach zero near a stretched-out pose, and comparing plain pseudo-inverse vs damped least squares behavior with actual joint velocity numbers.
- Chose "gearbox backlash compensation for robot arm joints": top pages are either generic mechanical-engineering explainers (lily-bearing, geartechnology) describing what backlash is, or dense patents on proprietary compensation methods; only one Arduino forum thread discusses practical software compensation, and none walk through measuring backlash from encoder position error at direction reversals or a concrete dead-band-inversion/lookup-table compensation approach for a robot joint.
- Weakness in current top pages: they explain backlash as a mechanical concept but skip the software/control side entirely, leaving a builder with an encoder-equipped joint no concrete way to measure or compensate for it in code.

### 2026-07-11
- Candidates checked: differential drive robot kinematics and wheel odometry, Gazebo vs PyBullet simulation choice, extended Kalman filter for robot localization, feedback control basics for beginners.
- Gazebo vs PyBullet: still saturated (re-confirmed from 2026-07-07) - comparison tables (Slashdot, SourceForge) and one dense arXiv paper, no new angle found.
- Extended Kalman filter localization: PythonRobotics and an independent tutorial (aleksandarhaber.com) already give full worked Python implementations with real matrices - gap too small for a fresh explainer.
- Chose "differential drive robot kinematics and wheel odometry": top pages are either FRC/WPILib-specific (Java API, competition-robot framing, not general robotics) or a solid but generic automaticaddison.com walkthrough; none quantify odometry drift with a concrete numeric example (encoder CPR, wheelbase, slip) or connect it back to a real encoder-equipped robot build.
- Weakness in current top pages: they derive the kinematics equations correctly but stop before showing how encoder tick noise and wheel slip actually accumulate into a numeric heading/position error over a real path.

### 2026-07-12
- Candidates checked: ROS2 DDS QoS settings explained, Denavit-Hartenberg parameters for robot arms, BLDC hall sensor commutation, feedback control basics for beginners.
- Denavit-Hartenberg parameters: well covered already by two automaticaddison.com articles, Robot Academy, and Universal Robots' own developer docs with clear worked tables - gap too thin.
- BLDC hall sensor commutation: coverage is mostly vendor/product-marketing blogs (mechtex, jkongmotor) describing the 120-degree sensor layout in prose, no code-level commutation state table.
- Feedback control basics for beginners: top results are thin AI-generated advice pages (LinkedIn, Vaia, Britannica) with no real block diagrams or numbers, but the topic overlaps heavily with the existing PID tuning article.
- Chose "ROS2 QoS settings explained": the official design doc and docs.ros.org page define reliability/durability/history correctly but read as dense policy reference; several Medium walkthroughs repeat the same policy list without a concrete failure. None show the classic mismatch bug (publisher on sensor-data best-effort QoS, subscriber left on default reliable) where the subscriber silently receives zero messages, with the actual ros2 topic info --verbose diagnostic output and the fix.
- Weakness in current top pages: they enumerate QoS policies correctly but never walk through why a QoS mismatch causes silent, no-error data loss or how to diagnose it on a real ROS2 system.

### 2026-07-12 (2)
- Candidates checked: BLDC hall sensor commutation state table, Gazebo vs PyBullet simulation choice, real-time considerations in robot control loops, ROS2 actions vs services vs topics.
- Gazebo vs PyBullet and real-time control loops: reconfirmed saturated/weak-gap from prior entries (2026-07-07, 2026-07-11), skipped again.
- ROS2 actions vs services vs topics: well covered already by docs.ros.org (three separate distro versions), automaticaddison.com, and The Construct with clear when-to-use guidance - gap too thin.
- Chose "BLDC hall sensor commutation with hall sensors, building the six-step table from scratch": top pages are MCU-vendor documentation (MATLAB/Simulink STM32 guide, NXP S32M276, TI E2E forum, Microchip devhelp) tied to a specific chip's peripheral registers, or marketing-style overviews (mechtex, jkongmotor, zbotic) that describe the 120-degree hall layout in prose without a hardware-agnostic state table a hobbyist can port to any microcontroller.
- Weakness in current top pages: none derive the six hall-state-to-phase-energization table from first principles (electrical angle, torque angle target of 90 degrees) in a way that is not locked to one vendor's specific timer/ADC peripheral, and none cover the classic wrong-direction/stall symptom when two hall wires are swapped.

### 2026-07-13
- Candidates checked: field-oriented control (FOC) for BLDC motors, Gazebo vs PyBullet simulation choice, ROS2 TF2 transforms explained, RRT vs A* path planning for mobile robots.
- Gazebo vs PyBullet: reconfirmed saturated again (2026-07-07, 2026-07-11, 2026-07-12), skipped.
- ROS2 TF2 transforms: well covered by Articulated Robotics, The Construct, and the official docs.ros.org page with clear tree-structure explanations - gap too thin.
- RRT vs A* path planning: mostly academic comparison papers (ResearchGate, PMC) with abstract performance claims, no worked numeric example on a small grid - a real angle exists but weaker than the FOC gap this cycle.
- Chose "field-oriented control (FOC) for BLDC motors explained": top pages are either vendor/product-marketing (mechtex "beginners guide", roboteq "ultra simple") that skip the actual Clarke/Park transform math, or dense academic-style pages (eurthtech) that give the transforms without a worked numeric example connecting hall/encoder angle to a concrete d-q current command. None bridge from the six-step trapezoidal commutation covered in the previous article to why FOC's sinusoidal current control gives smoother torque, with actual transform matrices and numbers.
- Weakness in current top pages: they name Clarke and Park transforms correctly but never walk through a single worked numeric example (three-phase currents to Iq/Id, then setting Id=0 for max torque per amp) that a hobbyist could reproduce in code.

### 2026-07-13 (2)
- Candidates checked: Space Vector PWM (SVPWM) for motor control, Extended Kalman Filter SLAM (EKF-SLAM) explained, forward kinematics and DH parameters, RRT vs A* path planning, shunt vs hall-effect current sensing for motor control.
- SVPWM: too close to the just-published FOC article (cannibalization risk), and already decently covered by vendor content (MathWorks, MotionControlTips, ElectroMDS) with adequate vector diagrams.
- DH parameters: genuine gap (notation-heavy academic sources) but roboticsunveiled.com already gives a fairly clear worked table, narrowing the edge.
- RRT vs A*: reconfirmed from 2026-07-13 entry, mostly academic comparison papers with no worked numeric grid example, weaker than the EKF-SLAM gap this cycle.
- Shunt vs hall-effect current sensing: already well served by solid vendor application notes (Bourns, Isabellenhuette, Elehub) with practical tradeoff tables.
- Chose "Extended Kalman Filter SLAM (EKF-SLAM) explained": top pages (andrewjkramer.net's EKF tutorial series, a UMass lecture PDF, jihongju.github.io's "hands-on" post) stay in symbolic matrix notation (x, P, F, H, K) or jump straight to code without showing the arithmetic for one full prediction+update cycle.
- Weakness in current top pages: none walk through a full numeric prediction+update cycle for a small concrete example (a differential-drive robot observing 2 landmarks) with actual state vector values, an actual covariance matrix, actual Jacobian entries, and an actual Kalman gain computed by hand.

### 2026-07-17
- Candidates checked: Denavit-Hartenberg parameters (reconfirmed), ROS2 actions vs services (reconfirmed), model predictive control for robot arms, absolute vs incremental encoders for robot joints.
- DH parameters and ROS2 actions vs services: reconfirmed saturated from prior entries (2026-07-12, 2026-07-13) - automaticaddison.com, Robot Academy, docs.ros.org, and The Construct already cover both well.
- MPC for robot arms: current coverage is almost entirely academic (arXiv, IEEE, thesis PDFs) or MATLAB/Simulink-locked tutorials - a real gap exists but the topic needs a linearized dynamic model and QP solver to show honestly, which risks going over scope for a hobbyist-facing 800-1300 word piece.
- Chose "absolute vs incremental encoders for robot joints, with a worked resolution-sizing example": top pages (RealPars, SICK, Hobber Drive, Snubber, gtencoder) explain the conceptual tradeoff (homing needed vs not, cost, noise immunity) well but stay qualitative.
- Weakness in current top pages: none show how to actually size encoder resolution for a target joint accuracy - converting arcminutes of required accuracy into encoder bits/PPR, then accounting for gear ratio multiplying effective resolution. This is a different angle from the already-published quadrature encoder wiring article, which covers wiring, not selection/sizing.

### 2026-07-17b
- Candidates checked: series elastic actuators for robot joints, motor and gearbox torque sizing for a robot arm joint, ROS2 actions vs services (reconfirmed), timing belt vs direct drive joint design, robot arm workspace/reachability analysis.
- ROS2 actions vs services: reconfirmed saturated again (2026-07-12, 2026-07-17 entries).
- Series elastic actuators: real gap (patents, IHMC/IntechOpen research pages, one product-blog overview) but every source stays conceptual/academic - a strong backup candidate for a future cycle once a concrete spring-stiffness worked example can be scoped tightly.
- Timing belt vs direct drive and workspace reachability: both reasonably covered already (GrabCAD/Dorna blog for belt vs direct drive tradeoffs; several arXiv reachability-map papers with sampling-based methods) - thinner gap than the motor sizing candidate.
- Chose "motor and gearbox torque sizing for a robot arm joint, worked example": a Physics Forums thread lays out the general worst-case-torque method in prose, but no page turns it into a full worked numeric calculation with a concrete link mass/length, a chosen safety factor, and a resulting gear ratio/motor selection.
- Weakness in current top pages: none show the complete chain from load torque (mass, length, gravity, acceleration) through a safety factor to a specific gear ratio choice and a check against the motor's continuous vs peak torque rating - builders are left to guess at safety margins.

### 2026-07-18
- Candidates checked: load cell force sensing and PID force control for robot grippers, H-bridge motor driver deadtime/shoot-through, particle filter (Monte Carlo) localization, ROS2 actions vs services (reconfirmed).
- ROS2 actions vs services: reconfirmed saturated again (2026-07-12, 2026-07-17, 2026-07-17b entries).
- Particle filter localization: decent existing coverage (Thrun's tutorial, Medium posts with simulation code, an interactive UT Austin demo) that already walks through the algorithm with code, narrowing the edge versus the gripper force-sensing candidate.
- H-bridge deadtime: allaboutcircuits already has a solid technical article on shoot-through and break-before-make timing, though it stops short of a worked deadtime-value calculation - a viable backup candidate for a future cycle.
- Chose "force sensing in robot grippers with a load cell, worked calibration and PID force control example": top pages (Robotiq blog, FUTEK, Interface, sensorsandgauges.com) are vendor/product pages that explain the concept and mention strain-gauge bridges qualitatively but never show the numeric chain from bridge output to a commanded force.
- Weakness in current top pages: none walk through converting a strain-gauge bridge's mV/V output through an instrumentation amplifier gain and ADC resolution into a calibrated force value, then closing a PID loop on that force signal with real numbers - builders are left without a concrete reference for tuning gain or interpreting ADC counts as grams of force.

### 2026-07-18b
- Candidates checked: ROS2 tf2 transforms explained, Monte Carlo localization (particle filter) for mobile robots, homing sequence and limit switch wiring for a robot arm joint, H-bridge deadtime (reconfirmed backup).
- Monte Carlo localization: reconfirmed decent existing coverage (Dellaert/Fox paper, Wikipedia, Robotics Knowledgebase AMCL page, an interactive UT Austin demo) that already walks through the algorithm conceptually and with code - thinner gap, and it would overlap heavily with the already-published Kalman filter/EKF-SLAM articles in the same cluster.
- Homing/limit switches: real forum activity (LinuxCNC forum, edaboard) but coverage is scattered CNC-axis-homing advice, not robot-arm-specific, and one vendor blog (source-robotics) already covers mastering/homing/calibration reasonably well - viable backup candidate.
- Chose "ROS2 tf2 transforms explained, with a worked homogeneous-transform example and why lookups fail": ROS Answers threads and a Foxglove blog post explain buffer/lookupTransform and canTransform conceptually, but stay at the API level.
- Weakness in current top pages: none show an actual worked 4x4 homogeneous transform composition (translation + rotation matrices multiplied through two or three frames with real numbers) next to a concrete explanation of the extrapolation-into-the-past/future error tied to buffer duration and message timestamps - builders get generic "check your frame names" advice instead of the actual timing/math mechanics.

### 2026-07-19
- Candidates checked: homing sequence and limit switch wiring for a robot arm joint (third look), Denavit-Hartenberg parameters worked example, Monte Carlo localization (reconfirmed), H-bridge PWM driver basics (reconfirmed saturated).
- Denavit-Hartenberg: automaticaddison.com and Robot Academy already give thorough worked tutorials with frame diagrams - thinner gap, and risks overlapping with the recently published tf2 homogeneous-transform article's matrix-math territory.
- Monte Carlo localization: reconfirmed decent existing coverage and continued overlap risk with the published Kalman filter/EKF-SLAM articles.
- H-bridge PWM driver: Arduino Forum, Instructables, DroneBot Workshop, and howtomechatronics all cover L298N/H-bridge wiring and code in detail - saturated for a general intro, though the deadtime/shoot-through angle noted earlier remains a viable backup.
- Chose "homing sequence and limit switch wiring for a robot arm joint, with a worked encoder-offset example": LinuxCNC forum and edaboard threads discuss homing informally and source-robotics covers mastering/calibration at a product level, but none walk through the actual encoder-count math (raw count at the switch trigger point, back-off distance, and the resulting home offset used to zero the joint) for a specific joint with real numbers.
- Weakness in current top pages: builders get generic "add a limit switch and home on startup" advice without seeing how the switch trigger point, a back-off/re-approach step for repeatability, and the encoder's counts-per-revolution combine into the actual offset constant used in firmware.

### 2026-07-20
- Candidates checked: EtherCAT for robot joint networks (cycle-time budget), Denavit-Hartenberg parameters (reconfirmed), cycloidal vs harmonic drive gearbox, ball screw vs lead screw actuator sizing, A* vs RRT path planning for mobile robots.
- Denavit-Hartenberg: reconfirmed saturated (automaticaddison.com, Robot Academy, roboticsunveiled.com all give thorough worked frame-assignment tutorials) and would overlap with the published tf2 homogeneous-transform article.
- Cycloidal vs harmonic drive: several vendor blogs (PlaPivot, Cone Drive, Honpine, howtomechatronics) already give solid qualitative and even torque/backlash test comparisons - thinner gap, and adjacent to the published harmonic-drive-vs-planetary-gearbox article.
- Ball screw vs lead screw: decent generic industrial-actuator coverage (Progressive Automations, Tolomatic, Actuonix) but stays at a component-catalog level, not robot-specific numeric sizing - viable backup.
- Chose "EtherCAT for robot joint networks: how the cycle-time budget actually works": Elmo, Honpine, and JEM Electronics compare EtherCAT vs CANopen at a feature/topology level (daisy-chain, on-the-fly processing, cable type), but none show the actual arithmetic of how per-slave forwarding delay, frame transmission time, and cable propagation combine into a real cycle time for N joints - a natural follow-up to the already-published CAN bus bit-timing article which did this for CAN.
- Weakness in current top pages: builders get "EtherCAT is faster because it processes on the fly" without ever seeing the actual budget math (frame length -> transmission time at 100 Mbit/s, plus per-slave forwarding delay, plus cable propagation) that determines whether a given axis count fits inside a 1 kHz or 4 kHz control cycle.

### 2026-07-21
- Candidates checked: cycloidal drive gear ratio sizing (reconfirmed), Denavit-Hartenberg parameters (reconfirmed), 6-axis force/torque sensor wrist calibration, A* vs RRT path planning for mobile robots, ball screw vs lead screw actuator sizing (third look).
- Cycloidal drive: reconfirmed thin gap - PlaPivot, Cone Drive, Honpine, and howtomechatronics already give solid qualitative and torque/backlash comparisons versus harmonic drives, adjacent to the published harmonic-drive-vs-planetary-gearbox article.
- 6-axis F/T sensor calibration: coverage is mostly research papers (maximum likelihood estimation, FBG-based sensors, bias drift studies) that are too abstract for a hobbyist-level worked example without oversimplifying a 6x6 calibration matrix - shelved as a future candidate needing more careful scoping.
- A* vs RRT: several academic comparison papers (ResearchGate, AIP, drpress) already quantify the tradeoff (RRT paths 22-25% longer, A* better in known/static environments) but stay at the algorithm-theory level - viable backup, no build-guide-style walkthrough with real grid coordinates found.
- Chose "ball screw vs lead screw for a robot linear actuator: worked torque sizing example": Progressive Automations, Tolomatic, and linearmotiontips give the generic torque formula (Torque = Thrust x Lead / (2 x Efficiency)) and efficiency numbers (ball screw ~0.9, lead screw as low as 0.4) but stay at an industrial-catalog level.
- Weakness in current top pages: none walk through sizing a screw actuator for an actual robot subsystem (e.g. a SCARA arm's Z-axis lift against gravity plus acceleration load) with real mass/lead numbers, comparing the resulting motor torque and holding-torque/backdrive behavior between a ball screw and a lead screw for that specific case.

### 2026-07-21b
- Candidates checked: sliding mode control for robot arm joints (worked example), Isaac Sim sim-to-real gap for a robot arm, null-space/redundancy resolution for a 7-DOF arm, cable-driven tendon actuator pretension sizing.
- Isaac Sim sim-to-real: NVIDIA Isaac Lab discussions and blog posts cover the concept well for industrial assembly (UR10e), but content skews toward RL-policy transfer rather than a general hobbyist-scale worked example - viable backup, needs tighter scoping.
- Null-space redundancy resolution: mostly research papers and patents (matrix augmentation, closed-loop CLIK) plus one closed-form 7DoF IK tutorial (Hackster.io NERO arm) - decent coverage already exists for that specific arm; thinner gap for a general worked numeric example.
- Cable-driven tendon actuator pretension: coverage is academic/research-paper level (MDPI, arXiv) on hand/finger mechanisms, no accessible build-guide-style sizing walkthrough - viable backup for a future cycle.
- Chose "sliding mode control for robot arm joints: a worked numeric example": MATLAB/Simulink has an API-level tutorial and the rest of the coverage is dense academic papers (finite-time SMC, disturbance observers) aimed at researchers, not a hobbyist trying to size a simple boundary-layer sliding surface.
- Weakness in current top pages: none show the actual numbers for a single robot joint (sliding surface s = e_dot + lambda*e, switching gain sized from real inertia/friction/disturbance bounds, then the saturation/boundary-layer trick that kills chattering) computed step by step - readers get either the abstract Lyapunov proof or a black-box MATLAB block, never the arithmetic in between. This also matches the standing 2026-07-16/2026-07-17/2026-07-21 strategy note flagging SMC as a backup candidate and the 2026-07-21 note to favor cluster 1 (Control Systems) for the next several cycles.

### 2026-07-22
- Candidates checked: PID integrator anti-windup for robot joints, joint velocity estimation from encoder counts, notch filter for mechanical resonance in servo tuning, Kalman filter Q/R matrix tuning.
- Anti-windup: solid general control-theory coverage (MATLAB/Simulink docs, Scilab, embeddedrelated code snippet, university lecture PDFs) explains back-calculation and clamping, but nothing robot-joint-specific with saturation numbers - viable backup.
- Notch filter for resonance: motioncontroltips and Synapticon already explain center frequency/width/depth at a usable conceptual level; Kalman Q/R tuning: Medium/Quora/ResearchGate give reasonable practical guidance - both gaps thinner.
- Chose "estimating robot joint velocity from encoder counts": top results are almost exclusively academic papers (Belanger et al. 1998 shaft-encoder velocity estimation, neural-network estimators, FPGA methods) and patents - no accessible practical walkthrough exists, and velocity feedback noise is a constant pain point in motor/servo forums.
- Weakness in current top pages: none show the arithmetic a builder needs - encoder resolution to one-count velocity step at a given loop rate (why a slow joint's raw derivative toggles between 0 and full steps), then a numeric comparison of windowed finite difference, low-pass filtered derivative, 1/T edge timing, and a tracking-loop observer with code.

### 2026-07-22b
- Candidates checked: ros2_control explained (controller manager / hardware interface), mecanum wheel kinematics worked example, S-curve vs trapezoidal jerk-limited motion profiles, DC motor constant (Kt/Ke/R) bench identification.
- ros2_control: saturated - official control.ros.org docs, Articulated Robotics, VnRobo and full Udemy courses already cover concepts step by step; gap too thin.
- S-curve profiles: PMD Corp "Mathematics of Motion Control Profiles" and motioncontroltips cover the math and rules of thumb well - viable backup, gap moderate. DC motor identification: motioncontroltips FAQ, Precision Microdrives and a Utah lab PDF cover the methods - backup.
- Chose "mecanum wheel kinematics: worked example": top results are academic papers (IJCA, Springer, ResearchGate) or shallow vendor/course docs (Ecam Eurobot, Hiwonder); constant demand from FTC/hobby omnidirectional builders; complements the existing differential drive kinematics article.
- Weakness in current top pages: none walk from a body velocity command (vx, vy, omega) through the 4-wheel inverse kinematics matrix with real geometry numbers (wheel radius, lx+ly lever arm) to actual wheel speeds in rad/s and RPM, including wheel-speed normalization when a motor saturates and why strafing is slower and drifts (roller losses, weight distribution).

### 2026-07-22c
- Candidates checked: PID anti-windup for robot joints (promoted from backup), S-curve jerk-limited motion profile worked example, DC motor parameter identification (Kt/Ke/R/J bench tests), DH parameters forward kinematics worked example.
- S-curve: reconfirmed moderate gap only (PMD Corp, motioncontroltips, FIRGELLI calculator cover the math); DH parameters: well covered by Robotiq blog, Clemson open textbook and multiple tutorials - gap thin; DC motor identification: still mostly papers/university PDFs (MDPI, Liu PDF) - remains a viable backup.
- Chose "PID anti-windup for robot joints: worked example": top pages are MATLAB/Simulink block docs, Scilab scheme overviews, a drilling-industry blog (Erdos Miller) and an arXiv review - all either toolbox-specific or generic process control, none robot-joint-specific.
- Demand signal: windup is a routine failure mode for saturated joint actuators (large setpoint steps, gravity loads); forum/Q&A discussions on PID overshoot after saturation are constant, and the topic directly extends the existing PID tuning article (internal link fit).
- Weakness in current top pages: none walk through the arithmetic - a joint motor hitting its torque/voltage limit on a big step, the integrator accumulating during saturation with real numbers, the resulting overshoot, then clamping vs back-calculation (choosing the tracking time constant Tt ~ sqrt(Ti*Td) or Ti/2) in discrete-time code a builder can drop into a 1 kHz loop.

### 2026-07-23
- Candidates checked: bearing selection for robot arm joints (moment loads), timing belt (GT2/HTD) drive sizing for robot joints, DIY cycloidal drive design, motor thermal sizing via RMS torque.
- Cycloidal drive: howtomechatronics already has a thorough design/3D-print/test walkthrough plus IMSystems and Firgelli explainers - gap thin. Motor thermal/RMS sizing: motioncontroltips and linearmotiontips cover the RMS method well and it overlaps our existing motor/gearbox sizing article - skipped.
- Timing belt drive sizing: top results are generic calculators, profile comparisons (HTD vs GT2) and vendor PDFs, no robot-joint worked example - viable backup for a future cycle.
- Chose "bearing selection for robot arm joints: worked moment load example": top-ranking pages are almost entirely bearing-vendor marketing (PIB Sales, HGT, Jiayi, Bearings Direct) that assert crossed rollers handle moment loads but show zero arithmetic; constant hobbyist question is whether two spaced ball bearings can replace an expensive crossed roller in a joint.
- Weakness in current top pages: none compute the actual tilting moment from payload and arm mass, the equivalent load on a crossed roller (P = X*(Fr + 2M/dp) + Y*Fa), the static safety factor against C0, or the force-pair math (F = M/L) showing how bearing spacing tames the same moment with ordinary deep groove bearings - and none translate bearing tilt stiffness into millimeters of sag at the tool tip.

### 2026-07-23 - S-curve (jerk-limited) trajectory worked example
- Candidates considered: ROS2 lifecycle/managed nodes, S-curve jerk-limited motion profile, asymmetric velocity profiles.
- Chose "S-curve jerk-limited trajectory: worked example" - natural sequel to the existing trapezoidal-profile article (#8), search discussion is steady (motion-control forums, machine-builder Q&A) and the topic is a recurring "why does my arm jerk at the start of a move" question.
- Content edge: I can walk the full 7-phase timing computation (jerk J, accel A, velocity V, displacement) with real numbers for one joint, then show how to detect the "short move" case where the profile never reaches max accel or max velocity.
- Weakness in top-ranking pages: they are either abstract research papers (asymmetric/optimal-jerk schemes, minimum-jerk polynomials) too heavy for a builder, or motion-control-tips explainers that describe the S-shape qualitatively but never compute the seven phase durations for a concrete move with real J/A/V limits.
- Deprioritized ROS2 lifecycle nodes: official ROS2 docs, Foxglove and learnros2 already cover the state machine well - gap too thin this cycle.

### 2026-07-23b
- Candidates checked: Denavit-Hartenberg forward kinematics worked example, servo vs stepper vs BLDC motor comparison, Kalman filter for robot state estimation, Monte Carlo localization (particle filter) worked example.
- DH parameters: reconfirmed gap too thin (Robotiq blog, Clemson open textbook already cover it well) - skipped again. Servo vs stepper vs BLDC and Kalman filter for robot state estimation: both already published on Arcbotix under these exact slugs - skipped as duplicates.
- Chose "Monte Carlo localization (particle filter) for mobile robots: a worked numeric example" - top pages are either academic slide decks (MIT, Berkeley), abstract Medium walkthroughs with code but no concrete numbers, or Wikipedia's conceptual summary; complements the existing EKF-SLAM and SLAM-basics articles by covering the non-Gaussian localization case.
- Weakness in current top pages: none carry a small particle set (e.g. 5-8 particles) through one full prediction-weight-resample cycle with actual pose numbers, a real landmark-range likelihood computation, and low-variance resampling arithmetic a builder can check by hand before trusting a library implementation.

### 2026-07-24
- Candidates checked: ROS2 lifecycle nodes, cycloidal vs harmonic drive gearboxes, voice coil actuator sizing for robot joints, Isaac Sim vs Gazebo comparison, motor thermal duty-cycle sizing for robot joints.
- ROS2 lifecycle nodes: reconfirmed thoroughly covered by official docs, Foxglove, and Medium walkthroughs - skipped again. Cycloidal vs harmonic: a substack piece and several vendor comparison pages (Cone Drive, PlaPivot, howtomechatronics with test data) already cover it well - skipped. Voice coil actuators: real coverage gap but the use case is niche (linear/haptic stages, rarely a robot joint) - deferred as a backup. Isaac Sim vs Gazebo: existing comparison blogs (Trossen, VnRobo, BlackCoffee) already give a fair qualitative rundown - too thin a gap for a worked-numeric piece.
- Chose "motor thermal duty-cycle sizing for a robot joint: a worked RMS current example" - top pages are either vendor generic explainers (The Robot Report), a forum thread with no math, or academic thermal-model papers (MDPI, Stanford climbing-robot PDF) too heavy for a builder.
- Weakness in current top pages: none walk through computing the actual RMS current over a real move-and-hold duty cycle, comparing it against a motor's continuous current rating, and showing the thermal time constant math that tells a builder how long they can run at peak current before the winding overheats - despite this being one of the most common motor-sizing follow-up questions after continuous-vs-peak torque selection.

## Strategy Adjustments

### 2026-07-23 audit (article 50)
- Dropped the blanket "deprioritize cluster 1" guidance from the 2026-07-22 audit: articles 47-50 (S-curve, bearing selection, cascaded PID, Monte Carlo localization) still found strong gaps in cluster 1 twice despite that guidance, while cluster 2/3 candidates like DH parameters, ROS2 lifecycle nodes, and cycloidal drive kept hitting repeat saturation. Let step-2 research pick the biggest gap per cycle instead of a fixed cluster rotation.
