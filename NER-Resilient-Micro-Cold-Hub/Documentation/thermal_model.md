# Thermal Model

## Chamber

The chamber is represented by a lumped thermal capacitance.

Wall heat gain:

Q_wall = (T_amb - T_chamber) / R_th

For the current design case:

- Ambient = 35 °C
- Initial chamber temperature = 13 °C
- R_th ≈ 3.08 K/W

Initial wall heat gain is therefore approximately:

Q_wall ≈ (35 - 13) / 3.08 ≈ 7.14 W

## Green banana model

For 3 kg of banana:

C_banana = m × Cp

Using Cp = 3.86 kJ/kg·K:

C_banana = 3 × 3860 = 11580 J/K

The banana-to-chamber heat-transfer model is:

C_b dT_b/dt = UA_b (T_ch - T_b)

with the current calibrated model value:

UA_b = 3 W/K

The banana starts at 35 °C while the chamber starts at 13 °C.

## Refrigeration control

The nominal simulated cooling capacity is 70 W.

A thermostat controls the refrigeration system using a 12.5–13.5 °C hysteresis band.

At the failure event, the compressor cooling term is forced to zero.

## Scope

This is a lumped system-level model. Refrigerant-cycle details, detailed spatial temperature gradients, packaging/contact resistance and experimental calibration are future validation tasks.
