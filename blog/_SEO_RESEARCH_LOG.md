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

## Strategy Adjustments

(No entries yet. Roughly every 5 published articles, review the research
entries above and decide whether blog/_BLOG_STRATEGY.md's "Topic Priority"
section still reflects reality. Log either the change made and why, or
"no change needed" and why, as a single dated line.)
