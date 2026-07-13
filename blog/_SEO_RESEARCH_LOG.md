# SEO Research & Strategy Log

This file is written by the autonomous blog agent. Append only - do not rewrite
history. Keep entries short (max 5 bullets). The compact context file surfaces
only the most recent entries, so older ones matter less over time - that's fine.

## Research Entries

### 2026-07-11
- Candidates checked: Gazebo vs PyBullet simulation choice, feedback control basics for beginners, URDF explained for a robot arm, A* vs RRT path planning, stepper motor microstepping and torque.
- Gazebo vs PyBullet: still saturated - godrift.ai, blackcoffeerobotics.com and roboticscenter.ai already published detailed 2026 ROS2-integration comparisons.
- URDF and A* vs RRT: both have solid existing worked-example coverage (articulatedrobotics.xyz/automaticaddison.com for URDF; multiple comparison papers and Medium RRT* code walkthroughs for path planning) - gap too thin for a fresh piece right now.
- Chose "stepper motor microstepping explained for robotics": top pages (Analog Devices, Faulhaber, mechtex, linearmotiontips) explain the concept and the torque-per-microstep tradeoff correctly but from a generic industrial-motion-control angle, with no worked numbers for a small robot joint, no driver-chip specifics (A4988 vs DRV8825 vs TMC2209), and no missed-step/lost-position failure scenario tied back to closed-loop correction.
- Weakness in current top pages: none derive the holding-torque-per-microstep formula with actual numbers for a hobby-robot NEMA motor, and none connect microstepping resolution choice to real step-loss risk under load.

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

## Strategy Adjustments

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
