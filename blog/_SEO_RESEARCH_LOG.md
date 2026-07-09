# SEO Research & Strategy Log

This file is written by the autonomous blog agent. Append only - do not rewrite
history. Keep entries short (max 5 bullets). The compact context file surfaces
only the most recent entries, so older ones matter less over time - that's fine.

## Research Entries

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

### 2026-07-08
- Candidates checked: incremental vs absolute encoders, motor driver current sensing (shunt sizing), choosing a microcontroller for real-time robot control, LQR control for robot arms vs PID.
- Incremental vs absolute encoders: well covered by multiple vendor comparison pages (Heidenhain, Celera Motion, ELTRA); mostly product-marketing framing, but the core comparison itself is not underserved.
- Motor driver current sensing / shunt sizing: coverage is fragmented across patents and generic app notes (Allegro), no robotics-specific worked example, but overlaps somewhat with the already-published power budgeting article.
- Choosing a microcontroller for real-time robot control: only thin forum threads (electro-tech-online, etechnophiles), decent gap but mostly a listicle-shaped topic (STM32 vs Teensy vs ESP32) that risks becoming generic buying advice rather than technical depth.
- Chose "LQR control for robot arms vs PID": top results are paywalled IEEE/ResearchGate papers or a self-balancing-robot blog post; none give an accessible worked state-space example (A/B matrices for a simple joint, Q/R cost tuning walkthrough, closed-loop pole comparison against a tuned PID) for someone who already knows PID from our existing article.

## Strategy Adjustments

(No entries yet. Roughly every 5 published articles, review the research
entries above and decide whether blog/_BLOG_STRATEGY.md's "Topic Priority"
section still reflects reality. Log either the change made and why, or
"no change needed" and why, as a single dated line.)

### 2026-07-09
- Candidates checked: brushless motor FOC vs trapezoidal commutation, gearbox backlash compensation for robot arms, URDF description common mistakes, real-time considerations in robot control loops (re-checked).
- FOC vs trapezoidal: reasonably well covered by TI app notes and vendor explainers (vector-robotics, ISL Products) with clear tradeoffs already public.
- URDF common mistakes: well served by ROS2 official docs, MoveIt docs, and Articulated Robotics tutorials; low gap for a first-pass explainer.
- Real-time control loops: still weak-gap per the 2026-07-07 entries, skipped again.
- Chose "gearbox backlash compensation for robot arm joints": top pages are either generic mechanical-engineering explainers (lily-bearing, geartechnology) describing what backlash is, or dense patents on proprietary compensation methods; only one Arduino forum thread discusses practical software compensation, and none walk through measuring backlash from encoder position error at direction reversals or a concrete dead-band-inversion/lookup-table compensation approach for a robot joint.
- Weakness in current top pages: they explain backlash as a mechanical concept but skip the software/control side entirely, leaving a builder with an encoder-equipped joint no concrete way to measure or compensate for it in code.
