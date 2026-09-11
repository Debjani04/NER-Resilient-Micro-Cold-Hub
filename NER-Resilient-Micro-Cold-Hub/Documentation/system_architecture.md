# System Architecture

## Core resilience concept

The cold hub uses multiple resilience layers:

```text
PV → MPPT → Battery → Energy Management → DC Refrigeration
                                      │
                                      ↓
                               Active cooling

A13 PCM → Thermal buffering → Temperature protection
                              during cooling failure

Sensors → Fault detection → Alert → Recovery/service action
```

The project differentiator is **low-downtime operation during failures**.

## Thermal balance

The chamber model uses:

C_ch dT_ch/dt = Q_wall + Q_banana - Q_PCM - Q_cool

Where:

- `Q_wall`: heat entering through insulation
- `Q_banana`: heat released by warm product
- `Q_PCM`: heat absorbed by PCM
- `Q_cool`: active refrigeration heat removal

During compressor failure, `Q_cool` becomes zero. The PCM then absorbs part of the incoming thermal load and slows chamber warming.
