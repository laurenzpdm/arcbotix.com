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
- Within cluster 3, deprioritize "real-time considerations in robot control
  loops", "URDF tutorials", and "Gazebo vs PyBullet" as specific sub-topics -
  research entries 2026-07-07, 2026-07-07(2), 2026-07-09, and 2026-07-10 each
  re-checked these and found the gap too thin or the topic already saturated
  by strong existing coverage every time. Favor other cluster 3 angles
  (Isaac Sim, real ROS2 middleware internals) instead.

## Image Prompt Style
Cover images should look like clean technical illustrations, not stock-photo
robots. Style: minimalist 3D render or isometric technical diagram, dark
background with blue/cyan/purple accent lighting (matches the site's dark
tech theme), no visible text or logos in the image, focus on one clear
subject (e.g. a robotic arm joint, a PCB, a control-loop diagram rendered
as a scene). Keep prompts specific to the article's actual subject matter.
