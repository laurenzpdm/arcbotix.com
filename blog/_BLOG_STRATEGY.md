## Goal
Arcbotix is an English-language robotics blog. It targets people who actually
build, study or work with robots: hobbyists building their first arm or rover,
students in mechatronics/robotics programs, and engineers looking for a
sharper explanation of a specific control-systems or hardware concept than
they got in their textbook. Optimize for genuinely useful, technically
correct, niche content - not generic "top 10 robots of 2026" listicles.

## Content Guidelines
- 800-1300 words per article.
- Write in clear, direct English. Assume the reader is technical but may be
  new to the specific sub-topic.
- Use h2, h3, p, ul, ol, blockquote where they genuinely help structure.
- Focus keyword in the title, meta description, first H2, and 2-3 times
  naturally in the body.
- Prefer concrete, checkable content: real formulas, real component names,
  real code snippets (pseudo-code or Python/C++ where relevant), real
  numbers. Avoid vague marketing language.
- 1-2 internal links to other Arcbotix articles where a natural connection
  exists. Do not force a link if none fits.
- No CTA block, no navigation, no footer, no analytics code - the template
  adds those.
- No em dashes or en dashes.
- No fabricated statistics, no fake citations, no invented product/company
  names presented as real.

## Topic Strategy
Rotate across these clusters so the blog doesn't read as one narrow niche:
1. **Control systems & math** - PID tuning, state estimation (Kalman filters),
   inverse kinematics, trajectory planning, feedback control basics.
2. **Actuators & hardware** - servo vs. stepper vs. BLDC motor tradeoffs,
   gearboxes/harmonic drives, sensors (IMU, LiDAR, encoders), power budgeting.
3. **Software & middleware** - ROS2 concepts explained practically, SLAM
   basics, simulation tools (Gazebo, PyBullet, Isaac Sim), real-time
   considerations.
4. **Build guides** - practical walkthroughs for a specific sub-system (e.g.
   "wiring a 6-DOF arm's encoders", "choosing a battery for a quadruped").
5. **Industry/career notes** - occasional grounded piece on robotics career
   paths, competitions (FRC, RoboCup), or a specific real robot's design
   decisions (only if verifiable, otherwise skip this cluster).

Prioritize clusters 1-3 for evergreen search value. Do not repeat a topic
already covered - check the slugs and titles list before choosing.

## Topic Priority (agent-adjustable)
This section is a live ranking, not a fixed rule. The blog agent may edit it
roughly every 5 published articles, based on blog/_SEO_RESEARCH_LOG.md
findings. Do NOT edit the cluster taxonomy above, the Goal, or the Content
Guidelines - only this ranked list and its one-line rationale per entry.
Keep it to 5-8 lines. Every change must have a dated rationale citing a
research log entry; no rationale, no edit.

- Default order: clusters 1, 2, 3 (evergreen, high signal), then 4, then 5.
  (baseline - 2026-07-07, no research yet)
- Within cluster 3, retire "Gazebo vs PyBullet" entirely - do not recheck it
  again. It was re-checked and found saturated in 8 separate research entries
  (2026-07-07, 2026-07-07(2), 2026-07-09, 2026-07-11, 2026-07-12,
  2026-07-12(2), 2026-07-13, 2026-07-14) with the same verdict every time,
  so further rechecks are wasted research effort. "URDF tutorials" stays
  deprioritized for the same saturation reason. "Real-time considerations in
  robot control loops" is no longer deprioritized - it was eventually found
  to have a real gap and published as article 25 on 2026-07-15. Favor other
  cluster 3 angles (Isaac Sim, real ROS2 middleware internals) instead.
- Within cluster 1, deprioritize "feedback control basics for beginners" -
  research entries 2026-07-07(2), 2026-07-11, and 2026-07-12 each re-checked
  it and found only thin generic advice-blog coverage, but also consistent
  conceptual overlap risk with the already-published PID tuning article.
  Real ROS2 middleware internals (cluster 3) has instead found a strong,
  concrete failure-scenario gap twice in a row (executors/callback groups,
  then QoS settings) - keep favoring that angle within cluster 3.
- Within cluster 1, retire "Denavit-Hartenberg parameters" entirely - do not
  recheck it again. Re-checked and found saturated in 4 separate research
  entries (2026-07-12, 2026-07-13(2), 2026-07-16, 2026-07-17) with the same
  verdict every time (automaticaddison.com, Robot Academy, and
  universal-robots.com already cover it thoroughly with worked tables) -
  further rechecks are wasted research effort. Favor other cluster 1 angles
  with a hobbyist worked-numeric gap instead, e.g. sliding mode control
  (backup candidate, kept for a future cycle per 2026-07-16 and 2026-07-17
  entries).
- Within cluster 3, retire "ROS2 actions vs services vs topics" entirely -
  do not recheck it again. Re-checked and found saturated in 3 separate
  research entries (2026-07-12, 2026-07-17, 2026-07-17b) with the same
  verdict every time (docs.ros.org across multiple distro versions,
  automaticaddison.com, The Construct already cover it thoroughly) -
  further rechecks are wasted research effort. Favor a hobbyist
  worked-numeric hardware/sizing angle instead - series elastic actuators
  is a noted backup candidate (2026-07-17b) once a concrete spring-stiffness
  example can be scoped tightly.
- Within cluster 2, the "joint network protocol" angle (CAN bus - chosen
  2026-07-16, EtherCAT - chosen 2026-07-20, RS-485/Modbus - chosen
  2026-07-20(2)) has now covered the three major fieldbuses used in robot
  joint networks back to back. Deprioritize further network-protocol picks
  for a few cycles - further picks here risk self-saturation from our own
  coverage rather than a real external gap. Articles 31-40 also skewed
  heavily to cluster 2/Hardware (5 of 10) with cluster 1/Control Systems
  underrepresented (1 of 10) - favor cluster 1 worked-numeric angles for the
  next several cycles (sliding mode control remains the noted backup per the
  2026-07-21 entry) and non-networking cluster 2 angles (actuators, sensors)
  over another protocol piece.
- Update to the prior "deprioritize cluster 1" note: despite that guidance,
  articles 47-50 still found strong worked-numeric gaps in cluster 1 twice
  (S-curve trajectory, cascaded PID, Monte Carlo localization) against only
  one cluster 2 pick (bearing selection), because the research step kept
  finding cluster-1 estimation/control topics with thin vendor/academic-only
  coverage while several cluster-2/3 candidates (DH parameters, ROS2
  lifecycle, cycloidal drive, motor thermal RMS sizing) hit repeat
  saturation. Drop the blanket cluster-1 deprioritization; let step-2
  research keep picking whichever cluster has the biggest gap that cycle.
  Confirmed-but-never-picked backups to draw from: DC motor parameter
  identification via Kt/Ke/R/J bench tests (2026-07-22b, 2026-07-22c) and
  H-bridge deadtime/shoot-through sizing (2026-07-18, 2026-07-18b,
  2026-07-19). (added 2026-07-23 audit at article 50)

## Image Prompt Style
Cover images should look like clean technical illustrations, not stock-photo
robots. Style: minimalist 3D render or isometric technical diagram, dark
background with blue/cyan/purple accent lighting (matches the site's dark
tech theme), no visible text or logos in the image, focus on one clear
subject (e.g. a robotic arm joint, a PCB, a control-loop diagram rendered
as a scene). Keep prompts specific to the article's actual subject matter.
