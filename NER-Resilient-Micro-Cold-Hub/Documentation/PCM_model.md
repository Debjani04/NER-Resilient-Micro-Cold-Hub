# A13 PCM Model

## Selected PCM

PlusICE A13 is used as the primary PCM in the current design.

Current nominal properties used for the model:

- Phase-change temperature: 13 °C
- Latent heat: 225 kJ/kg
- Density: 775 kg/m³
- Specific heat: 2.16 kJ/kg·K
- Thermal conductivity: 0.22 W/m·K

## Enthalpy representation

The PCM is treated as a thermal storage state.

Conceptually:

E_PCM = sensible energy + latent energy

and the latent contribution is represented through a phase/state-of-charge variable.

The PCM heat-transfer term is:

Q_PCM = UA_PCM (T_chamber - T_PCM)

The chamber receives this term with a negative sign:

Q_wall + Q_banana - Q_PCM - Q_cool

## Important interpretation

A13 is a **thermal backup**, not an electrical backup.

It does not run the compressor. It absorbs thermal energy when active cooling is unavailable.

The current validated simulation demonstrates thermal buffering during a 6-hour compressor-failure test. It does not establish multi-day PCM-only backup.
