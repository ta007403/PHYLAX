// ============================================================
// HARDWARE WALLET CASE — Parametric OpenSCAD
// 2.42" SSD1309 OLED + 2x E-Switch TL1105YF160Q tact switches + USB-C
// PCB: 75 x 120 x 1.6mm
// ============================================================
//
// HOW TO USE THIS FILE
// ---------------------------------------------------------------
// Open the CUSTOMIZER panel: Window menu > Customizer (or the icon that
// looks like a slider/wrench in the toolbar). You'll see grouped controls:
//   - "View / Render Mode"     <- pick which part to look at / export
//   - "PCB", "Display", "Buttons", "USB-C Connector", "PCB Mounting Screws"
//   - "Case Shell", "Screw Bosses", "Front Shell Lip"
//
// To switch parts: open "View / Render Mode" and change the render_mode
// dropdown to back_shell / front_shell / button_cap / assembly.
//
// To print: pick a part in render_mode (NOT "assembly", that's preview-only),
// then File > Export > Export as STL. Repeat for each of the 3 parts
// (back_shell, front_shell, button_cap -- button_cap exports both caps
// laid out side by side in one file).
//
// Any value you change in the Customizer updates the model live. If you'd
// rather edit numbers directly in code, the same variables are declared in
// SECTION 1 / 1b below (search for the variable name) -- Customizer and
// direct code editing both work on the same values.
//
// PRINTING NOTES
// ---------------------------------------------------------------
// - Two shells (back_shell, front_shell) + two button_cap copies = 4 prints total.
// - Tolerances below are tuned for FDM with a 0.4mm nozzle. If you switch
//   to resin/SLA, look for "Front Shell Lip" group and tighten lip_clearance.
// - Back shell: print with the open face UP (no supports needed for the
//   bosses, since they're vertical cylinders rising from a flat floor).
// - Front shell: print with the BUTTON/DISPLAY face DOWN on the bed, since
//   the registration lip on the back is just a thin wall (prints fine
//   either way, but face-down avoids any visible seam on the visible side).
// - Button caps: print either orientation; they're small and simple.
//
// ============================================================

// Render quality
$fn = 64;

// I have modify this section
hex_round_head_m3_high = 1.65;
hide_m3_head = 4 - hex_round_head_m3_high;

/* [View / Render Mode] */
// Which part to show. Pick one, then File > Export > STL to print it.
render_mode = "assembly"; // [assembly:Assembly (preview only), back_shell:Back Shell (print 1x), front_shell:Front Shell (print 1x), button_cap:Button Caps (print 2x), display_lock:Display Lock (print 1x),front_and_lock:Front Shell + Display Lock, pcb_outline:PCB Outline (export as DXF for KiCad), none:Nothing]

/* [PCB] */
pcb_length   = 95;   // [60:200] mm, long axis (Y)
pcb_width    = 60.5;    // [40:150] mm, short axis (X)
pcb_thick    = 1.6;   // [0.8:0.1:3.2] mm

/* [Display - 2.42" SSD1309] */
disp_mod_w     = 70.9;   // mm, module long edge (runs along PCB width/X)
disp_mod_h     = 43.4;   // mm, module short edge (runs along PCB length/Y)
disp_active_w  = 55.01;  // mm, active viewing area width
disp_active_h  = 27.49;  // mm, active viewing area height
disp_pcb_thick = 1.2;    // mm, OLED module PCB thickness (assumption, thin FR4)
disp_glass_standoff = 0.5; // mm, assumption: glass sits slightly proud of module PCB
disp_margin_top = 10;     // [0:20] mm, gap from top edge of PCB to top edge of display module
disp_window_margin = 1.5; // [0.5:0.1:4] mm, extra margin around active area for the front cutout

/* [Buttons - Same Sky TS15-1212 Series] */
btn_body        = 12.0;   // mm, switch body (12x12mm per TS15 datasheet)
btn_plunger_d   = 7.0;    // mm, round actuator diameter (per TS15 mechanical drawing)
btn_plunger_h   = 4.8;   // [5:0.5:15] mm, actuator height above PCB -- set to match
                           // your ordered variant: 100=10mm, 150=15mm, 200=20mm (wrong series -- TS15 max is 15mm)
btn_spacing     = 30;     // [15:80] mm, center-to-center distance between the two buttons
btn_offset_below_display = 18; // [5:50] mm, gap from bottom of display to button row
btn_travel_above_case = 1.8; // [0.5:0.1:4] mm, how far the button DOME pokes above the front
                              // face -- this is what controls "how proud/clicky" the button
                              // looks and feels. Independent of plunger height: the shaft
                              // length to reach the plunger is calculated automatically.

/* [USB-C Connector] */
// Pick your connector type — all dimensions auto-adjust.
usbc_type = "normal"; // [sink:Sink Type - Amphenol 10178589 (IPX5 waterproof), normal:Normal SMD USB-C (standard)]

// Clearance added around the oval cutout on ALL sides.
// 0.4mm = safe FDM starting point. Decrease if plug is loose, increase if too tight.
usbc_clearance = 0.0; // [0.1:0.05:1.0] mm

/* [FPC Display Connector - Molex 522072460] */
// 24-circuit, 1mm pitch, right-angle SMD, 2.70mm height
// Place this connector so the FPC ribbon exits toward the display module above it.
fpc_w           = 26.0;  // mm, connector body width (24 circuits × 1mm pitch + housing ends ~2mm)
fpc_d           = 5.5;   // mm, connector body depth (right-angle footprint)
fpc_h           = 2.7;   // mm, connector height above PCB (from datasheet: 2.70mm)
// Position: centered on X, placed in the top half of PCB near the display edge
fpc_offset_from_top = 8; // [2:30] mm, distance from top PCB edge to near edge of connector


/* [PCB Mounting Screws - M3 + Nut] */
// PCB now mounts to the FRONT shell (display side), not the back shell.
// Screw enters from the OUTSIDE of the front shell (visible head, countersunk),
// passes through the PCB, and threads into a hex nut trapped inside the front
// shell's cavity wall. This lets the PCB stay attached to the front shell when
// the case is opened -- keeping the display's short FPC cable untouched.
mount_inset      = 5;    // [5:20] mm, distance of each screw position from PCB edge.
                           // Must clear BOTH the rounded case corners AND the
                           // display window edges -- 17mm verified clear of both
                           // with margin (M3 boss is 5mm dia). If you change
                           // disp_window size, case_corner_r, or pcb_boss_od,
                           // re-check this.
mount_hole_d     = 3.4;   // [3.0:0.1:4.0] mm, PCB clearance hole for M3 screw shank
m3_screw_d       = 3.0;   // mm, M3 screw nominal diameter (reference only)
m3_clear_d       = 3.4;   // [3.2:0.1:4.0] mm, clearance hole through front shell wall + PCB
m3_head_d        = 6.0;   // [5.5:0.1:7.0] mm, M3 COUNTERSUNK (flat head) screw head
                           // diameter -- DIN 965/ISO 7046 spec, e.g. M3x8 has 6.0mm head.
                           // Use a countersunk screw (not cap/pan head) so it sits flush.
m3_head_h        = 1.7;   // [1.5:0.1:2.5] mm, M3 countersunk head height (DIN 965 spec) --
                           // much shallower than a cap/pan head, fits cleanly within
                           // front_panel_t without needing a backing pad.
m3_nut_af        = 5.5;   // [5.3:0.1:6.0] mm, M3 hex nut width across flats
m3_nut_h         = 2.4;   // [2.0:0.1:3.0] mm, M3 hex nut thickness
m3_nut_clearance = 0.2;   // [0.05:0.05:0.4] mm, extra clearance around nut so it slides into the trap

/* [Display Lock Screws - M3 + Nut] */
// Two small M3 screws below the display window, used to hold a separate
// printed retainer piece that clamps the display's BOTTOM edge once it has
// been slid into the 3-sided L-channel (top/left/right) molded into the
// front shell. Positions are tied to the display window, not hardcoded,
// so they follow disp_center_x/y automatically if the display moves.
disp_lock_inset_x  = 8;    // [2:20] mm, how far in from each window side-edge
disp_lock_offset_y = 8;    // [2:20] mm, gap below the window's bottom edge
disp_lock_boss_od  = 5.0;  // [3:0.5:8] mm, lock screw boss outer diameter
                            // (smaller than the main PCB bosses -- this only
                            // holds a thin retainer clip, not the whole PCB)

/* [Hidden] */
disp_center_x   = pcb_width/2;
disp_center_y   = pcb_length - disp_margin_top - disp_mod_h/2;
usbc_center_x = pcb_width/2;
btn_center_y    = disp_center_y - disp_mod_h/2 - btn_offset_below_display;
btn_center_x_L  = pcb_width/2 - btn_spacing/2;
btn_center_x_R  = pcb_width/2 + btn_spacing/2;

mount_positions = [
    [mount_inset, mount_inset],
    [pcb_width - mount_inset, mount_inset],
    [mount_inset, pcb_length - mount_inset],
    [pcb_width - mount_inset, pcb_length - mount_inset]
];

/* [Case Shell] */
fit_clearance   = 0.4;     // [0.1:0.05:1] mm, gap between PCB edge and inner case wall (per side)
wall_t          = 1.8;     // [1.2:0.1:4] mm, outer shell wall thickness.
                            // Must be > usbc_cut_h/2 (= (usbc_h + clearance*2)/2 ≈ 2.27mm)
                            // to avoid thin crescent walls at the USB-C oval ends.
                            // 2.5mm is the safe minimum. Thicker = stronger "Never Die" case.
front_panel_t   = 3.0;     // [1.0:0.1:4] mm, front shell face thickness.
                            // Must exceed m3_head_h by at least 0.8mm so the
                            // countersink rim (where the screw head presses)
                            // has adequate material -- 3.0mm gives a healthy
                            // 1.3mm rim above the 1.7mm M3 countersunk head.
case_corner_r   = 8;       // [2:0.5:16] mm, outer corner radius (iPhone-like rounded corners)
floor_t         = 2.0;     // [1.0:0.1:3] mm, back shell floor thickness.
                            // 2.0mm matches front_panel_t — both are "faces" that
                            // JLCPCB measures as walls. Also stronger floor for
                            // the "Never Die" concept.
component_clearance = 0.5; // [0.2:0.1:2] mm, extra air gap above the tallest internal component

/* [Screw Bosses] */
pcb_boss_od           = 6.0;   // [4:0.5:9] mm, outer diameter of internal PCB standoff
                                // bosses. Must be wide enough that the annular wall
                                // around the M3 clearance hole (m3_clear_d) stays
                                // above 0.8mm -- 6.0mm gives a healthy 1.3mm ring.
shell_boss_od         = 6.0;   // [3:0.5:8] mm, outer diameter of shell-to-shell assembly bosses
shell_screw_d         = 3.4;   // [1.5:0.1:3] mm, shell screw shank diameter (M2 typical)
shell_screw_head_d    = 3.8;   // [2.5:0.1:6] mm, shell screw head diameter
shell_screw_head_h    = 2.0;   // [1:0.1:4] mm, shell screw head height
shell_boss_edge_inset = 7.0;   // [4:20] mm, shell boss distance from short-edge wall
shell_boss_straddle   = 12;    // [6:30] mm, shell boss distance off the centerline (X)

/* [PCB Spacer - clears switch body bulge under the board] */
// Some tactile switches have a bulge / lip on the underside of the body
// that sticks out past the PCB edge of the footprint -- these spacers sit
// directly under each M3 mount point and lift the PCB enough to clear that
// bulge, in addition to the main M3 boss. Tied to mount_positions, so they
// automatically follow mount_inset / pcb_width / pcb_length if you change them.
pcb_spacer_d          = pcb_boss_od;     // [4:0.5:9] mm, same OD as the main M3 boss
pcb_spacer_bore_d     = pcb_boss_od - 2.6; // mm, inner bore (clearance around the M3 boss/shaft)
pcb_spacer_h          = 3.8 + 0.5;     // [1:0.5:10] mm, spacer height -- tune to clear your
                                // switch's actual body bulge thickness
pcb_spacer_z          = 3;     // [0:0.5:10] mm, Z position where the spacer ring starts
                                // (front-shell-local coords, z=0 is the outer/visible face)

/* [Front Shell Lip] */
// The front shell has a downward-facing lip that drops INTO the back shell's
// cavity, registering against the inner wall for a flush, gap-free seam --
// this is the detail that gives the "premium" tight-tolerance look.
lip_clearance = 0.35;  // [0.1:0.05:0.6] mm, lip-to-inner-wall fit clearance.
                        // 0.35mm/side is a safe FDM default (0.4mm nozzle).
                        // Tighten to ~0.15-0.2mm for resin/SLA.
lip_depth     = 2.5;   // [1:0.5:6] mm, how far the lip drops into the back shell
lip_wall_t    = 1.5;   // [0.8:0.1:2.5] mm, thickness of the lip wall itself.
                        // Keep >= 1.5mm for JLCPCB FDM (their min is 0.8mm but
                        // thin walls near corners can go below that after rounding).

/* [Hidden] */
// Everything below this point is CALCULATED from the parameters above.
// Don't edit these directly -- change the source values above instead.

case_outer_w    = pcb_width  + 2*(fit_clearance + wall_t);
case_outer_l    = pcb_length + 2*(fit_clearance + wall_t);

disp_total_height = disp_pcb_thick + disp_glass_standoff; // height of display stack above PCB top
back_wall_h = pcb_thick + max(disp_total_height, btn_plunger_h + 1.5 + 0.5) + component_clearance; //Actually This is front wall if you want more shell high you can play with btn_plunger_h then you will see everything
// note: buttons need clearance for cap engagement, displays need clearance for glass — back wall height covers from PCB-seat-plane to rim

// PCB now mounts to the FRONT shell. PCB sits at a height ABOVE the panel's
// outer face (z=0) equal to the tallest component's reach (button plunger or
// display stack) -- so that when components grow from PCB's bottom face
// toward the panel (in -Z), their tips land right at the panel cutouts.
// This standoff height IS the M3 boss height (the physical post between the
// panel's inner face and PCB's bottom surface).
pcb_mount_standoff_h = max(disp_total_height, btn_plunger_h + 1.5); // mm, boss height =
                             // tallest component's reach, so its tip lands at the panel.
pcb_seat_z      = pcb_mount_standoff_h;  // PCB bottom Z position (front-shell-local,
                                          // z=0 is the panel's OUTER/visible face)

// Switch support bosses — solid posts directly under each button switch.
// Purpose: prevent PCB flex when user presses buttons hard repeatedly.
// "Never Die" concept: eliminates solder joint fatigue on the switch pins.
// These are SOLID (no pilot hole) — pure compression support, max strength.
// Height = same as pcb_boss_h so PCB sits perfectly flat across all support points.
// Positions: directly under each switch center, in case-world coordinates.
sw_support_boss_od = pcb_boss_od;  // same diameter as PCB corner bosses (5mm)
// Height: spans from the back_shell lid's inner face all the way to the PCB's
// TOP surface (component side -- supporting it from the side OPPOSITE the
// button press direction, still fully effective against PCB flex). Computed
// as the total front_shell cavity height minus the space already used by
// the PCB standoff + PCB thickness on the panel side.
sw_support_boss_h  = (front_panel_t + back_wall_h) - (pcb_mount_standoff_h + pcb_thick);

shell_boss_positions = [
    [case_outer_w/2 - shell_boss_straddle, shell_boss_edge_inset],
    [case_outer_w/2 + shell_boss_straddle, shell_boss_edge_inset],
    [case_outer_w/2 - shell_boss_straddle, case_outer_l - shell_boss_edge_inset],
    [case_outer_w/2 + shell_boss_straddle, case_outer_l - shell_boss_edge_inset]
];

// Display window (front shell cutout) — slightly larger than active area, smaller than module
disp_window_w = disp_active_w + 2*disp_window_margin;
disp_window_h = disp_active_h + 2*disp_window_margin;

// Button cap holes in front shell
btn_hole_d      = btn_plunger_d + 1.6; // clearance for cap shaft to move freely
cap_shaft_d     = btn_hole_d - 0.4;    // printed cap shaft (slip fit in hole)
cap_head_d      = btn_body + 0.6;      // cap head diameter (covers switch body footprint, like an iPhone-style button)

// The shaft must bridge the REAL air gap between the plunger's tip and the
// panel's OUTER (visible) face at z=0 -- by construction, pcb_mount_standoff_h
// equals the tallest component's reach, so the tallest component's tip
// already lands at (or very near) z=0. The shaft mainly needs to span
// front_panel_t (the panel thickness itself) plus a small preload so the
// cap presses firmly against the switch with no rattle.
cap_preload     = 0.4; // [0:0.05:1.5] mm, how much the shaft overshoots the gap (firm contact, no rattle)
plunger_top_z   = pcb_mount_standoff_h - 1.5 - btn_plunger_h; // global Z, plunger tip (should be ~0)
cap_engage_h    = (front_panel_t - plunger_top_z) + cap_preload; // shaft length: spans from
                                                                   // the plunger tip, through
                                                                   // the panel, to the outer face

// USB-C oval cutout — dimensions auto-selected based on usbc_type.
//
// SINK TYPE (Amphenol 10178589, IPX5):
//   - Connector sinks 1.20mm INTO the PCB
//   - Case opening per datasheet page 2: 6.20mm wide x 3.73mm tall
//   - Connector center Z above PCB TOP surface: (4.20mm total - 1.20mm sink) / 2 = 1.50mm
//   - Sealing ring seats against the case wall — needs clean flat surface, our wall_t is fine
//
// NORMAL SMD USB-C (standard):
//   - Sits ON TOP of PCB, standard spec opening 8.94 x 2.56mm
//   - Connector center Z above PCB TOP surface: ~1.60mm

// Raw connector opening dimensions (before adding clearance)
usbc_w = (usbc_type == "sink") ? 6.20  : 10.5;  // case opening width  (mm)
usbc_h = (usbc_type == "sink") ? 3.73  : 4.48;  // case opening height (mm)

usbc_corner_r = 1.5;

// Rounded-rectangle cutout for the USB-C port, extruded along Y (through the
// top wall). Same orientation convention as usbc_oval -- centered at origin
// in X/Z -- just using a small corner radius instead of a full stadium.
module usbc_rounded_rect(w, h, r, depth) {
    translate([0, -2, 0 + 0.5])
    rotate([90, 0, 0])
    translate([0, 0, -depth])
    linear_extrude(height = depth + 1)
        translate([-w/2, -h/2])
            rounded_rect(w, h, r);
}

// How far the connector's vertical center sits above the PCB TOP surface
usbc_sink_depth   = (usbc_type == "sink") ? 1.20 : 0;    // how far body sinks INTO PCB
usbc_body_h       = (usbc_type == "sink") ? 4.20 : 3.20; // total connector body height
usbc_center_above_pcb = (usbc_body_h - usbc_sink_depth) / 2; // center above PCB top surface

// Final cut dimensions (raw + clearance)
usbc_cut_w = usbc_w + 2*usbc_clearance;
usbc_cut_h = usbc_h + 2*usbc_clearance + 0.3;
usbc_cut_r = usbc_cut_h / 2;

// Z center of the oval in case-world (front-shell-local) coordinates.
// USB-C connector is mounted on PCB's BOTTOM (component) face, growing in
// -Z toward the panel at z=0 -- same direction as the display and buttons.
usbc_cut_z_center = pcb_seat_z + 1.32 + usbc_sink_depth - usbc_body_h/2;

// Front shell screw clearance + countersink (screws pass through front shell
// into the back shell's shell_boss_positions)
shell_screw_clear_d   = shell_screw_d + 0.4;  // clearance hole, not threaded
shell_screw_csk_d     = shell_screw_head_d + 0.4;
shell_screw_csk_depth = shell_screw_head_h + 0.3;


// ------------------------------------------------------------
// 2. HELPER MODULES
// ------------------------------------------------------------

// 2D rounded rectangle, corner radius r, centered at origin-relative (0,0) to (w,l)
module rounded_rect(w, l, r) {
    hull() {
        translate([r, r])             circle(r=r);
        translate([w-r, r])           circle(r=r);
        translate([r, l-r])           circle(r=r);
        translate([w-r, l-r])         circle(r=r);
    }
}

// Extruded rounded box, from z=0 to z=h, footprint w x l with corner radius r
module rounded_box(w, l, h, r) {
    linear_extrude(height=h)
        rounded_rect(w, l, r);
}

// Stadium (oval) extruded along Y — used for the USB-C cutout.
// w = total width (X), h = total height (Z), depth = how deep to cut (Y).
// Centered at origin in X and Z, extruded in +Y.
// Shape: rectangle with two fully-rounded semicircle ends (radius = h/2).
module usbc_oval(w, h, depth) {
    r = h / 2;
    translate([0, -2, 0])
    rotate([90, 0, 0])         // extrude along Y axis
    translate([0, 0, -depth])
    linear_extrude(height = depth + 1)
        hull() {
            translate([ (w/2 - r), 0]) circle(r = r);
            translate([-(w/2 - r), 0]) circle(r = r);
        }
}

// Hex nut trap: a hexagonal pocket sized to hold an M3 nut captive so it
// can't spin while tightening the screw. af = width across flats.
// Extrudes from z=0 to z=h, hexagon centered at origin in XY.
module hex_nut_trap(af, h) {
    // Hex circumradius from width-across-flats: r = af / sqrt(3) ... actually
    // for a regular hexagon, af = 2 * r * cos(30deg), so r = af / (2*cos(30deg))
    r = af / (2 * cos(30));
    linear_extrude(height = h)
        circle(r = r, $fn = 6);
}

// PCB spacer ring: a short standoff with a clearance bore, positioned at
// one mount point. Used to lift the PCB clear of a switch body's underside
// bulge. Pass in the mount-position XY (already in front-shell-local case
// coords, i.e. pcb_origin_x/y + mount_positions[i]).
module pcb_spacer(pos) {
    difference() {
        translate([pos[0], pos[1], pcb_spacer_z])
            cylinder(d = pcb_spacer_d, h = pcb_spacer_h);
        translate([pos[0], pos[1], pcb_spacer_z - 1])
            cylinder(d = pcb_spacer_bore_d, h = pcb_spacer_h + 2);
    }
}

// ------------------------------------------------------------
// 3. REFERENCE MODULE — visualize PCB + components for sanity check
// ------------------------------------------------------------

// PCB origin offset within the case (so PCB corner aligns with case interior corner)
pcb_origin_x = fit_clearance + wall_t;
pcb_origin_y = fit_clearance + wall_t;
pcb_origin_z = pcb_seat_z;

// Switch support boss positions — defined here because they depend on pcb_origin_x/y
sw_support_positions = [
    [pcb_origin_x + btn_center_x_L, pcb_origin_y + btn_center_y],
    [pcb_origin_x + btn_center_x_R, pcb_origin_y + btn_center_y]
];

// Display lock screw positions — tied directly to the display window's real
// bounds (case-world coords), so they automatically follow disp_center_x/y,
// pcb_origin_x/y, and disp_window_w/h if any of those change later.
disp_window_left_x   = pcb_origin_x + disp_center_x - disp_window_w/2;
disp_window_right_x  = pcb_origin_x + disp_center_x + disp_window_w/2;
disp_window_bottom_y = pcb_origin_y + disp_center_y - disp_window_h/2;

disp_lock_positions = [
    [disp_window_left_x  + disp_lock_inset_x, disp_window_bottom_y - disp_lock_offset_y],
    [disp_window_right_x - disp_lock_inset_x, disp_window_bottom_y - disp_lock_offset_y]
];

module pcb_reference() {
    // IMPORTANT: in the NEW front_shell architecture, the panel (display
    // window, button holes, USB-C, M3 heads) sits at z=0, and PCB sits
    // further into the cavity (higher Z). Components (display, buttons,
    // USB-C) are mounted on the PCB face that's CLOSEST to the panel --
    // which is PCB's BOTTOM surface (at pcb_origin_z) -- and they grow
    // in -Z (toward the panel), not +Z (which would grow away from it).
    translate([pcb_origin_x, pcb_origin_y, pcb_origin_z]) {
        color("darkgreen")
        cube([pcb_width, pcb_length, pcb_thick]);

        // Display module footprint -- mounted on PCB's bottom (panel-facing)
        // surface, growing in -Z toward the panel.
        color("black", 0.85)
        translate([disp_center_x - disp_mod_w/2, disp_center_y - disp_mod_h/2, -disp_pcb_thick])
            cube([disp_mod_w, disp_mod_h, disp_pcb_thick]);

        // Active area outline (below the display module, closer to panel)
        color("cyan", 0.6)
        translate([disp_center_x - disp_active_w/2, disp_center_y - disp_active_h/2, -disp_pcb_thick - 0.2])
            cube([disp_active_w, disp_active_h, 0.2]);

        // Buttons -- plunger grows in -Z toward the panel/button cap
        color("orange")
        for (cx = [btn_center_x_L, btn_center_x_R]) {
            translate([cx, btn_center_y, 0]) {
                cube([btn_body, btn_body, 1.5], center=true);
                translate([0,0,-1.5-btn_plunger_h])
                    cylinder(d=btn_plunger_d, h=btn_plunger_h);
            }
        }

        // USB-C connector at TOP edge — shown correctly for each type.
        // Still grows from PCB bottom face (component side).
        color("silver")
        translate([usbc_center_x - usbc_w/2,
                   pcb_length - 1,
                   -usbc_body_h + usbc_sink_depth])
            cube([usbc_w, 3, usbc_body_h]);

        // Mounting holes
        color("red")
        for (p = mount_positions) {
            translate([p[0], p[1], -1])
                cylinder(d=mount_hole_d, h=pcb_thick+2);
        }
    }
}

// ------------------------------------------------------------
// 4. FRONT SHELL (deep main body: PCB mounts here via M3+nut, display
//    window, button holes, USB-C cutout, registration lip for the back lid)
// ------------------------------------------------------------
// PCB stays attached to the FRONT shell when the case is opened, so the
// display's short FPC ribbon cable never gets stressed or disconnected.
// M3 screws enter from the OUTSIDE (visible, countersunk on the display
// face), pass through the front wall + PCB, and thread into hex nut traps
// molded into bosses rising from the front shell's inner cavity wall.

module front_shell() {
    total_h = front_panel_t + back_wall_h;
    overlap = 0.6;       // overlap used for the registration lip fusing into the panel

    // With a proper M3 COUNTERSUNK screw (m3_head_h=1.7mm), the countersink
    // now fits cleanly within front_panel_t (2.0mm) -- no backing pad needed.
    // The boss is one continuous cylinder from just inside the panel (small
    // overlap for clean fusion) all the way to the PCB seat height.
    m3_boss_d     = pcb_boss_od;            // standard boss diameter
    m3_boss_start = -0.3;                    // small overlap into the panel for fusion
    m3_boss_h     = pcb_mount_standoff_h - m3_boss_start; // reaches the PCB seat height

    // PCB spacers: one per mount position, tied directly to mount_positions
    // (and therefore to mount_inset / pcb_width / pcb_length automatically --
    // no hardcoded coordinates to go stale if those change later).
    for (p = mount_positions) {
        pcb_spacer([pcb_origin_x + p[0], pcb_origin_y + p[1]]);
    }

    // Upper display locking
    difference() {
        translate([1.8, 85, 3])
            cube([61.3, 5, 3.8]);
        translate([1.8, 83 - 0.9, 3])
            cube([61.3, 5, 2.2]);
        
        translate([22.25, 83, 3]) //This is a cut for pass the display cable out of here.
            cube([20.2, 8, 10]); //This position need to be center of the display and leave 20.2 mm
    }
    
    // Left display locking
    difference() {
        translate([1.8, 49, 3])
            cube([5, 39, 3.8]);
        translate([1.8 + 0.2, 49, 3])
            cube([7, 39, 2.2]);
    }
    
    // Right display locking
    difference() {
        translate([58.1, 49, 3])
            cube([5, 38, 3.8]);
        translate([58.1 - 1.2, 49, 3])
            cube([6, 38, 2.2]);
    }
    
    // Front Cover to make it beautiful
    translate([3.5, 80.1, 0])
        cube([58, 0.7, 3]);

    // Display LOCK SCREW bosses — two M3 bosses below the window, for the
    // separate bottom-retainer piece that clamps the display's lower edge
    // after it's slid into the 3-sided L-channel above. Same boss+nut-trap
    // mechanism as the main PCB mounts, just smaller (disp_lock_boss_od)
    // since this only needs to hold a thin clip, not the whole PCB.
    //for (p = disp_lock_positions) {
    //    translate([p[0], p[1], m3_boss_start])
    //        cylinder(d = disp_lock_boss_od, h = pcb_mount_standoff_h - m3_boss_start);
    //}

    difference() {
        union() {
            rounded_box(case_outer_w, case_outer_l, total_h, case_corner_r);

            // ONE continuous M3 boss per mount position -- combines the role
            // of "countersink backing material" and "PCB standoff" in a
            // single cylinder primitive, so there's no internal seam that
            // could produce non-manifold geometry at a boolean union.
            for (p = mount_positions) {
                translate([pcb_origin_x + p[0], pcb_origin_y + p[1], m3_boss_start])
                    cylinder(d=m3_boss_d, h=m3_boss_h);
            }
        }
        
        // Add by Tar for cut the M3 hole for lock both front shell and back shell together
        translate([20.45,7, -1]) //Right Lower
            cylinder(d=shell_screw_d + 0.3, h=20);
        translate([44.45, 7, -1]) //Left Lower
            cylinder(d=shell_screw_d + 0.3, h=20);
        translate([20.45, 92.40, -1]) //Right Upper
            cylinder(d=shell_screw_d + 0.3, h=20);
        translate([44.45, 92.40, -1]) //Left Upper
            cylinder(d=shell_screw_d + 0.3, h=20);
        
        translate([20.45, 7, -1]) //Right Lower
            linear_extrude(height = 2.65)
                circle(r = 2.85, $fn = 64);
        translate([44.45, 7, -1]) //Left Lower
            linear_extrude(height = 2.65)
                circle(r = 2.85, $fn = 64);
        translate([20.45, 92.40, -1]) //Right Upper
            linear_extrude(height = 2.65)
                circle(r = 2.85, $fn = 64);
        translate([44.45, 92.40, -1]) //Left Upper
            linear_extrude(height = 2.65)
                circle(r = 2.85, $fn = 64);
        

        // Hollow interior cavity (PCB + components live in here).
        // Extends past total_h to guarantee the top is fully open (no thin
        // cap left behind) -- back_shell (flat lid) closes this opening.
        translate([wall_t, wall_t, front_panel_t])
            rounded_box(case_outer_w - 2*wall_t, case_outer_l - 2*wall_t, total_h, case_corner_r - wall_t);

        // USB-C oval cutout through the TOP wall.
        // usbc_cut_z_center is already a full case-world Z coordinate
        // (derived from pcb_seat_z), so it's used directly -- NOT added
        // to pcb_origin_z again, which would double-count the offset.
        translate([pcb_origin_x + usbc_center_x,
                   case_outer_l,
                   usbc_cut_z_center])
            usbc_rounded_rect(usbc_cut_w, usbc_cut_h, usbc_corner_r, wall_t + 2);

        // Display window cutout (through the OUTER face, front_panel_t thick)
        translate([pcb_origin_x + disp_center_x - disp_window_w/2,
                   pcb_origin_y + disp_center_y - disp_window_h/2,
                   -1])
            cube([disp_window_w, disp_window_h, front_panel_t + 2]);

        // Button holes (through the OUTER face) -- rounded square, 10mm side, 1mm corner radius
        btn_hole_w = 12.2; // mm, square side length
        btn_hole_r = 1.2;  // mm, corner radius
        for (cx = [btn_center_x_L, btn_center_x_R]) {
            translate([pcb_origin_x + cx - btn_hole_w/2, pcb_origin_y + btn_center_y - btn_hole_w/2, -1])
                linear_extrude(height = front_panel_t + 2)
                    rounded_rect(btn_hole_w, btn_hole_w, btn_hole_r);
        }

        // M3 cuts: clearance hole (full depth through the boss), countersink
        // (recessed into the outer face, pushed deeper by hide_m3_head so a
        // rounded button-head screw sits fully below the surface, not just
        // flush), and hex nut trap (recessed into the boss top, PCB-facing
        // side) -- all subtracted from the single continuous boss cylinder
        // above, in this same top-level difference().
        for (p = mount_positions) {
            translate([pcb_origin_x + p[0], pcb_origin_y + p[1], m3_boss_start - 1])
                cylinder(d=m3_clear_d, h=m3_boss_h + 2);
            translate([pcb_origin_x + p[0], pcb_origin_y + p[1], front_panel_t - m3_head_h - hide_m3_head])
                cylinder(d=m3_head_d + 0.4, h=m3_head_h + 1);
            translate([pcb_origin_x + p[0], pcb_origin_y + p[1], pcb_mount_standoff_h - m3_nut_h])
                hex_nut_trap(m3_nut_af + m3_nut_clearance, m3_nut_h + 1);
        }

        // Display lock screw cuts: clearance hole through panel + boss,
        // countersink in the outer face, and hex nut trap at the boss top.
        // Same hide_m3_head treatment as the main mounts (recessed button
        // head), same nut-trap mechanism, just at the disp_lock_positions.
        for (p = disp_lock_positions) {
            translate([p[0], p[1], m3_boss_start - 1])
                cylinder(d = m3_clear_d, h = (pcb_mount_standoff_h - m3_boss_start) + 2);
            translate([p[0], p[1], front_panel_t - m3_head_h - hide_m3_head])
                cylinder(d = m3_head_d + 0.4, h = m3_head_h + 1);
            translate([p[0], p[1], pcb_mount_standoff_h - m3_nut_h])
                hex_nut_trap(m3_nut_af + m3_nut_clearance, m3_nut_h + 1);
        }
        
    }

    // NOTE: switch support bosses moved to back_shell() -- they conflict with
    // the button hole cutouts here (same XY position, no panel material left
    // to fuse into). Supporting the PCB from the BACK (opposite the button
    // press direction) achieves the same "Never Die" anti-flex purpose.

    // NOTE: registration lip lives on back_shell() now (the simple flat lid),
    // not here -- this mirrors the OLD design where the lid (not the tray)
    // carried the lip. See back_shell() below.

    // Shell-to-shell screw bosses (hold the back lid on) — same as before,
    // rising from the front shell's inner wall near the cavity opening.
    shell_boss_eps = 0.1; // small overlap into the panel for clean fusion
    for (p = shell_boss_positions) {
        translate([p[0], p[1], front_panel_t - shell_boss_eps])
            difference() {
                cylinder(d=shell_boss_od, h=back_wall_h - 1 + shell_boss_eps - 0.8);
                translate([0,0, -1])
                    cylinder(d=shell_screw_d + 0.3, h=back_wall_h + 1);
                
                
            }
    }
}

// ------------------------------------------------------------
// 5. BACK SHELL (simple flat lid — closes the cavity, no PCB attachment)
// ------------------------------------------------------------
// The PCB stays with the front shell now, so this lid is just a flat cover
// with screw clearance holes for the shell-to-shell assembly screws.

module back_shell() {
    screw_boss_pad_d = shell_screw_csk_d + 2.4 + 1;
    screw_boss_pad_h = 1.8;
    overlap2 = 0.6;

    // Registration lip: drops DOWN from the lid's inner face into the front
    // shell's open cavity end, registering against its inner wall for a
    // flush, gap-free seam (same mechanism as the old design, just now on
    // the lid instead of the tray's former lid).
    lip_outer_w = case_outer_w - 2*wall_t - 2*lip_clearance;
    lip_outer_l = case_outer_l - 2*wall_t - 2*lip_clearance;
    lip_r       = case_corner_r - wall_t - lip_clearance;

    difference() {
        union() {
            rounded_box(case_outer_w, case_outer_l, floor_t, case_corner_r);

            // Local thickening pads on the inner face for countersink material
            for (p = shell_boss_positions) {
                translate([p[0], p[1], -screw_boss_pad_h])
                    cylinder(d=screw_boss_pad_d, h=screw_boss_pad_h + overlap2);
            }

            // Registration lip, dropping down from the lid's inner face
            translate([wall_t + lip_clearance, wall_t + lip_clearance, -lip_depth])
                difference() {
                    rounded_box(lip_outer_w, lip_outer_l, lip_depth + overlap2, lip_r);
                    translate([lip_wall_t, lip_wall_t, -1])
                        rounded_box(lip_outer_w - 2*lip_wall_t, lip_outer_l - 2*lip_wall_t,
                                    lip_depth + 3, max(lip_r - lip_wall_t, 0.1));
                }

            // Switch support bosses — SOLID posts reaching from the lid's
            // inner face across the cavity to meet the PCB's BOTTOM surface.
            // "Never Die" concept: prevents PCB flex under heavy button use,
            // supporting from the side opposite the press direction.
            for (p = sw_support_positions) {
                translate([p[0], p[1], -sw_support_boss_h + overlap2])
                    cylinder(d=sw_support_boss_od, h=sw_support_boss_h);
            }
        }

        // Shell screw clearance holes + countersinks (screws come from the
        // OUTSIDE of the back lid, threading forward into the front shell's
        // shell_boss_positions bosses).
        for (p = shell_boss_positions) {
            translate([p[0], p[1], -screw_boss_pad_h - 1])
                cylinder(d=shell_screw_clear_d, h=floor_t + screw_boss_pad_h + 2);
            translate([p[0], p[1], floor_t - shell_screw_csk_depth])
                cylinder(d=shell_screw_csk_d, h=shell_screw_csk_depth + 1);
        }
        
        // Add by Tar for install M3 hex nut
        translate([20.45, 7, -0.3]) //Right Lower
            linear_extrude(height = 2.5)
                circle(r = 3.5, $fn = 6);
        translate([44.45, 7, -0.3]) //Left Lower
            linear_extrude(height = 2.5)
                circle(r = 3.5, $fn = 6);
        translate([20.45, 92.4, -0.3]) //Right Upper
            linear_extrude(height = 2.5)
                circle(r = 3.5, $fn = 6);
        translate([44.45, 92.4, -0.3]) //Left Upper
            linear_extrude(height = 2.5)
                circle(r = 3.5, $fn = 6);
        
    }
}

// ------------------------------------------------------------
// 6. BUTTON CAP (separate printed part, sits on switch plunger)
// ------------------------------------------------------------
flange_d  = btn_hole_d + 1.6;
flange_h  = 0.6;
post_d    = cap_head_d;
top_round_h = post_d * 0.22;
post_h    = max(btn_travel_above_case - flange_h - top_round_h, 0.2);

module button_cap() {
    union() {
        cylinder(d=cap_shaft_d, h=cap_engage_h);
        translate([0, 0, cap_engage_h - 0.01])
            cylinder(d=flange_d, h=flange_h);
        translate([0, 0, cap_engage_h + flange_h - 0.01])
            cylinder(d=post_d, h=post_h + 0.01);
        translate([0, 0, cap_engage_h + flange_h + post_h])
            scale([1, 1, top_round_h / (post_d/2)])
                sphere(d = post_d);
    }
}

module display_lock() {
    // Lower display lock with M3 front front shell
    translate([-0.5,-4,-4.5]) {
        difference() {
            translate([3.15, 42, 8]) //To make it close this need to be 3 but we have to print separate part. We insert display first and then we screw this part later.
                cube([60, 11, 3.8]);
            
            translate([12.0, 46.25, 5])
                cylinder(h=20, d=3.4, center=true);
            translate([12.0, 46.25, 9.4])
                linear_extrude(height = 3)
                    circle(r = 3.5, $fn = 6);
            
            translate([54.0, 46.25, 5])
                cylinder(h=20, d=3.4, center=true);
            translate([54.0, 46.25, 9.4])
                linear_extrude(height = 3)
                    circle(r = 3.5, $fn = 6);
        }
    }
}

// ------------------------------------------------------------
// 9. RENDER SWITCH
// ------------------------------------------------------------
if (render_mode == "back_shell") {
    back_shell();
} else if (render_mode == "front_shell") {
    front_shell();
} else if (render_mode == "button_cap") {
    translate([-8, 0, 0]) button_cap();
    translate([8, 0, 0]) button_cap();
} else if (render_mode == "display_lock") {
    display_lock();
} else if (render_mode == "front_and_lock") {
    front_shell();
    display_lock();
} else if (render_mode == "pcb_outline") {
    disp_outline_w = 0.3; // mm, line thickness for the module reference frame
    shell_boss_pcb_clear_d = shell_boss_od + 0.4; // mm, lets the full boss body pass through

    difference() {
        square([pcb_width, pcb_length]);

        // Mount holes
        for (p = mount_positions) {
            translate([p[0], p[1]])
                circle(d = mount_hole_d);
        }

        // Button holes
        for (cx = [btn_center_x_L, btn_center_x_R]) {
            translate([cx, btn_center_y])
                circle(d = btn_hole_d);
        }

        // USB-C cutout (stadium shape, same dims used by the case cutout)
        translate([usbc_center_x, pcb_length])
            hull() {
                translate([-(usbc_cut_w/2 - usbc_cut_h/2), 0]) circle(d = usbc_cut_h);
                translate([ (usbc_cut_w/2 - usbc_cut_h/2), 0]) circle(d = usbc_cut_h);
            }

        // Display ACTIVE AREA -- the real functional opening, fully cut
        translate([disp_center_x - disp_active_w/2, disp_center_y - disp_active_h/2])
            square([disp_active_w, disp_active_h]);

        // Shell-to-shell boss clearance -- the boss BODY passes through the
        // PCB's thickness, so this needs to clear the full boss diameter,
        // not just the screw shank. shell_boss_positions is in case-world
        // coords (already offset by pcb_origin_x/y), so subtract that back
        // out to land correctly on this PCB-local square.
        for (p = shell_boss_positions) {
            translate([p[0] - pcb_origin_x, p[1] - pcb_origin_y])
                circle(d = shell_boss_pcb_clear_d);
        }

        // Display-lock screw holes -- boss stops right at the PCB's edge
        // (doesn't pass through it), so plain M3 shank clearance is enough.
        // disp_lock_positions is also case-world, same offset correction.
        for (p = disp_lock_positions) {
            translate([p[0] - pcb_origin_x, p[1] - pcb_origin_y])
                circle(d = m3_clear_d);
        }
    }

    // Display MODULE FOOTPRINT -- reference outline only (thin frame), so it
    // stays visible as its own boundary even though it fully encloses the
    // active-area hole cut above.
    difference() {
        translate([disp_center_x - disp_mod_w/2, disp_center_y - disp_mod_h/2])
            square([disp_mod_w, disp_mod_h]);
        translate([disp_center_x - disp_mod_w/2 + disp_outline_w, disp_center_y - disp_mod_h/2 + disp_outline_w])
            square([disp_mod_w - 2*disp_outline_w, disp_mod_h - 2*disp_outline_w]);
    }
} else if (render_mode == "assembly") {
    total_h_assembly = front_panel_t + back_wall_h;
    color("Gainsboro", 0.95) front_shell();
    color("Gainsboro", 0.95) display_lock();
    translate([0, 0, total_h_assembly])
        color("SteelBlue", 0.95) back_shell();
    for (cx = [btn_center_x_L, btn_center_x_R]) {
        translate([pcb_origin_x + cx, pcb_origin_y + btn_center_y, plunger_top_z])
            rotate([180, 0, 0])
                color("orange") button_cap();
    }
    %pcb_reference();
}
