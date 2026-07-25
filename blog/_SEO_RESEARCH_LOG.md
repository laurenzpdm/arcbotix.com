# SEO Research & Strategy Log

This file is written by the autonomous blog agent. Append only - do not rewrite
history. Keep entries short (max 5 bullets). The compact context file surfaces
only the most recent entries, so older ones matter less over time - that's fine.

## Research Entries

### 2026-07-24 (2)
- Candidates checked: encoder vs resolver comparison for robot joints (mostly patent/product-page level, moderate overlap with the already-published absolute-vs-incremental-encoder article), current sense resistor/shunt sizing for motor drivers (solid general electronics coverage from NXP, TI, Firgelli calculators, but overlaps heavily with the published torque-control-robot-arm-joints-current-sensing article), PWM switching frequency selection for motor drivers (decent hobbyist coverage already exists from Zbotic, Portescap, Progressive Automations with concrete frequency ranges), DH parameters worked example (reconfirmed saturated, automaticaddison.com still has the definitive walkthrough), holding brake sizing for a robot arm joint.
- Chose "Holding Brake Sizing for a Robot Arm Joint: A Worked Fail-Safe Torque Example": Firgelli's servo-brake page and sepac.com give the generic clamping-force times friction-radius formula and KEB/arxiv note that axes 2-3 of industrial arms carry the biggest brakes, but none show a full worked calculation that starts from a real link mass/length gravity torque, reflects it through a gearbox to the motor-side brake location, and applies a safety factor to pick a catalog brake size.
- Weakness in current top pages: no page walks through the motor-side vs output-side brake placement tradeoff (torque divided by gear ratio at the motor side, but backlash and gearbox failure exposure at the output side) or shows the release-time math that determines how far a vertical joint free-falls before a spring-applied brake engages after an e-stop.

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

### 2026-07-24b
- Candidates checked: harmonic drive vs planetary gearbox comparison, Kalman filter for robot state estimation, servo vs stepper vs BLDC motor comparison, PID controller tuning for robotic arms with Ziegler-Nichols, inverse kinematics explained.
- Harmonic vs planetary gearbox: a substack piece explicitly titled "Selection Guide 2026" plus two vendor comparison pages already cover load/backlash/ratio tradeoffs thoroughly - skipped. Kalman filter for robot state estimation and servo vs stepper vs BLDC: both overlap heavily with already-published Arcbotix articles (EKF-SLAM, IMU fusion, BLDC commutation, stepper microstepping) - skipped as near-duplicates. Inverse kinematics: robotacademy.net.au and the Clemson open textbook already give a clean 2-joint geometric worked example - gap too thin.
- Mistakenly drafted and published a "PID controller tuning for robotic arms" Ziegler-Nichols piece, then caught mid-cycle that article #1 (pid-controller-tuning-for-robotic-arms, 2026-07-03) already covers this exact topic including the Ziegler-Nichols table - it was present in the Slugs Already Used list but easy to miss as a single long unbroken line. Reverted the publish (removed the html/webp/json, restored registry/index) before committing anything.
- Recovered by searching two fresh hardware candidates instead of relying only on the (partly stale) keyword pool: voice coil actuator sizing (FEA/patent sources only, no clean worked sizing walkthrough, but niche use case for a robot joint) and shunt resistor current sensing for motor drivers.
- Chose "current sensing circuit design for robot motor drivers: a worked shunt resistor sizing example" - top pages are vendor app notes (Allegro, NXP), a TI datasheet, and a forum thread, none of which size a shunt value, amplifier gain, and ADC resolution together for a concrete robot joint current range, and this is distinct from the existing torque-control article which covers the current-loop control math, not the sensing hardware itself.
- Weakness in current top pages: none walk through picking a shunt resistance from a target current range and power dissipation budget, then sizing the sense-amplifier gain and checking the resulting ADC resolution in amps per LSB for a specific robot joint's continuous/peak current numbers.

### 2026-07-25
- Candidates checked: Ackermann steering kinematics for robots (worked example), cycloidal drive gear ratio sizing (re-checked), Denavit-Hartenberg forward kinematics (re-checked), battery management system (BMS) design for mobile robots.
- Cycloidal drive: reconfirmed saturated again, same conclusion as 2026-07-20, 2026-07-21, and 2026-07-23 - howtomechatronics, IMSystems and Firgelli already give thorough design/formula walkthroughs. DH parameters: reconfirmed saturated (automaticaddison.com, Robotiq, Clemson textbook). BMS design: real vendor coverage (NXP, Highleap, large-battery.com) already explains cell balancing and protection functions clearly at a usable level - gap thinner and more hardware-buying-guide shaped than formula driven.
- Chose "Ackermann steering kinematics for robots: a worked example": top pages are MATLAB/MathWorks reference docs, the ROS2_control kinematics page, and a robotics textbook chapter that state the ẋ, ẏ, θ̇ equations and the inner/outer wheel steering-angle formulas correctly but never run them through a concrete wheelbase/track-width numeric example.
- Weakness in current top pages: none compute an actual turning radius and the resulting inner/outer front wheel steering angles for a real car-like robot (wheelbase, track width, requested turn radius), and none show why a single ideal Ackermann angle applied to both front wheels causes tire scrub, or connect it back to differential-drive/mecanum kinematics already covered on the site for comparison.

### 2026-07-25b
- Candidates checked: harmonic drive vs planetary gearbox worked example (already published as harmonic-drive-vs-planetary-gearbox, initially missed under a different slug name), hand-eye calibration for a robot arm camera (eye-in-hand, AX=XB), quaternion vs Euler angle representation for robot orientation, A* path planning for mobile robots on a grid.
- Harmonic vs planetary reconfirmed already published under an existing slug - caught before drafting by grepping the full Slugs Already Used list rather than trusting the stale Keyword Pool. Quaternion vs Euler: CH Robotics, Medium and academic PDFs explain gimbal lock and the quaternion math well but stayed conceptual. A*: well covered generically (Red Blob Games style content elsewhere) even though academic sources note a lack of worked numeric examples, so the robotics-specific edge is thin.
- Chose "Hand-Eye Calibration for a Robot Arm Camera: A Worked Numeric Example (Eye-in-Hand, AX=XB)": MathWorks, MoveIt docs and academic papers state the AX=XB formulation and mention the Daniilidis/Tsai-Lenz solvers correctly, but a search summary explicitly noted none of them carry a concrete numeric example through the pose-pair collection and solve.
- Weakness in current top pages: none walk a builder through collecting 2-3 real robot-pose/camera-pose pairs, forming the A and B relative transforms, and showing why a single pose pair is degenerate (rotation axis must vary) before the AX=XB system is solvable - it stays abstract matrix algebra with no concrete numbers.

## Strategy Adjustments

### 2026-07-23 audit (article 50)
- Dropped the blanket "deprioritize cluster 1" guidance from the 2026-07-22 audit: articles 47-50 (S-curve, bearing selection, cascaded PID, Monte Carlo localization) still found strong gaps in cluster 1 twice despite that guidance, while cluster 2/3 candidates like DH parameters, ROS2 lifecycle nodes, and cycloidal drive kept hitting repeat saturation. Let step-2 research pick the biggest gap per cycle instead of a fixed cluster rotation.


---
Ältere Einträge: `_SEO_RESEARCH_LOG_ARCHIVE.md` — nur bei explizitem historischem Bedarf lesen, sonst greppen.
