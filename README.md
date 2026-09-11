# ❄️ NER-Resilient Micro Cold Hub

> A MATLAB/Simulink-based thermal resilience model for decentralized micro cold storage, designed to study how **A13 Phase Change Material (PCM)** protects stored produce during refrigeration failure.

## Overview

Cold-storage systems in remote and decentralized agricultural regions can become vulnerable when refrigeration fails or power availability becomes unreliable.

The **NER-Resilient Micro Cold Hub** focuses on **failure resilience and low downtime**.

Instead of treating solar power or IoT monitoring as the primary innovation, this project investigates whether **thermal buffering using A13 PCM** can slow chamber temperature rise when active refrigeration is unavailable.

The current MATLAB/Simulink model evaluates a small cold-storage chamber containing green bananas and compares its thermal response:

- **With A13 PCM**
- **Without PCM**

under a simulated compressor failure.

---

## 🎯 Project Objective

The objective is to develop and validate a cold-storage architecture capable of:

- Maintaining suitable storage temperature during normal operation
- Detecting and responding to refrigeration failures
- Using PCM as passive thermal protection during cooling interruption
- Reducing temperature rise during compressor failure
- Increasing the time available for maintenance or system recovery
- Supporting future integration with PV, battery storage and intelligent energy management

---

## 💡 Core Idea

The resilience architecture is based on multiple layers:

```text
PV
 │
 ▼
MPPT
 │
 ▼
Battery
 │
 ▼
Intelligent Energy Management
 │
 ▼
DC Refrigeration
 │
 ▼
Cold Chamber
 │
 ├──────── A13 PCM Thermal Buffer
 │
 └──────── Sensors & Fault Detection
```

The **PCM is a thermal backup**, not an electrical backup.

During compressor failure, active cooling becomes unavailable while the PCM absorbs thermal energy entering the chamber, slowing the temperature increase.

---

## 🧊 Current Simulation Model

The current validation case uses:

| Parameter | Value |
|---|---:|
| Chamber volume | 30 L |
| Ambient temperature | 35 °C |
| Initial chamber temperature | 13 °C |
| Insulation | 40 mm PUF |
| Product | Green banana |
| Banana mass | 3 kg |
| Banana initial temperature | 35 °C |
| Banana specific heat used | 3.86 kJ/kg·K |
| Banana heat-transfer coefficient (UA) | 3 W/K |
| Cooling capacity used in model | 70 W |
| Thermostat range | 12.5–13.5 °C |
| Compressor failure time | 12 h |
| Total simulation time | 18 h |
| Failure observation period | 6 h |

---

## 🌡️ Thermal Model

The chamber is represented using a lumped thermal-capacitance model.

The chamber energy balance is:

```text
Cch × dTch/dt = Qwall + Qbanana - QPCM - Qcool
```

where:

- `Qwall` = heat entering through chamber insulation
- `Qbanana` = heat transferred from the stored product
- `QPCM` = heat absorbed by the PCM
- `Qcool` = heat removed by the refrigeration system

During compressor failure:

```text
Qcool = 0
```

The PCM then acts as a passive thermal buffer.

---

## 🍌 Dynamic Product Model

Green banana is represented as a separate thermal mass rather than assuming that the product temperature is always equal to the chamber temperature.

The product model is:

```text
Cbanana × dTbanana/dt =
UAbanana × (Tchamber - Tbanana)
```

with:

```text
Cbanana = mbanana × Cp,banana
```

For the current 3 kg simulation:

```text
Cbanana = 3 × 3860
        = 11580 J/K
```

This allows the model to simulate the cooling of initially warm produce inside the chamber.

---

## 🧪 A13 PCM Model

The selected PCM for the current model is **PlusICE A13**.

Nominal properties used:

| Property | Value |
|---|---:|
| Phase-change temperature | 13 °C |
| Latent heat | 225 kJ/kg |
| Density | 775 kg/m³ |
| Specific heat | 2.16 kJ/kg·K |
| Thermal conductivity | 0.22 W/m·K |

The PCM subsystem is based on an **enthalpy / state-of-charge representation**.

Conceptually:

```text
PCM Energy = Sensible Energy + Latent Energy
```

Heat exchange between the chamber and PCM is represented by:

```text
QPCM = UAPCM × (Tchamber - TPCM)
```

The PCM absorbs heat when the chamber becomes warmer than the PCM.

---

## ⚙️ Compressor Failure Simulation

The refrigeration system operates normally for the first:

```text
12 hours
```

The compressor is then forced OFF:

```text
Failure time = 43,200 s
```

The model continues for another:

```text
6 hours
```

giving a total simulation duration of:

```text
64,800 s = 18 hours
```

Two separate simulations are compared:

```text
CASE 1 → A13 PCM connected
CASE 2 → PCM bypassed
```

All other model parameters remain unchanged.

---

## 📊 Simulation Results

### Compressor Failure: With vs Without A13 PCM

| Metric | With A13 PCM | Without PCM |
|---|---:|---:|
| Final chamber temperature | **14.8727 °C** | **18.1353 °C** |
| Failure observation period | 6 h | 6 h |
| Final temperature reduction due to PCM | **3.2626 °C** | — |

Therefore:

```text
Temperature reduction
= 18.1353 - 14.8727
= 3.2626 °C
```

### Main Result

**A13 PCM reduced the chamber temperature by approximately 3.26 °C relative to the no-PCM case after six hours of compressor failure.**

This demonstrates the ability of PCM thermal storage to significantly slow chamber warming when active refrigeration is unavailable.

---

## 📈 Failure Comparison

![A13 PCM Compressor Failure Comparison](results/figures/compressor_failure_A13_PCM_comparison.jpeg)

The comparison demonstrates the separation between the PCM and no-PCM cases after compressor failure.

During normal operation, thermostatic control maintains chamber temperature approximately within the intended operating band.

After compressor failure, the no-PCM chamber warms substantially faster, while the PCM-equipped chamber experiences a slower temperature rise.

---

## 🛡️ Why This Matters

The goal is not simply to build another solar-powered cold-storage system.

The project focuses on the question:

> **What happens when the cooling system fails?**

For decentralized agricultural cold storage, failures may not be repaired immediately.

Thermal buffering can provide additional time for:

- Fault detection
- Operator notification
- Maintenance response
- Refrigeration recovery
- Power restoration
- Produce relocation

This forms the core **failure-resilience / low-downtime** approach of the project.

---

## 🧠 Planned Fault-Detection Architecture

The complete system is intended to monitor:

```text
Chamber Temperature
        +
Evaporator Temperature
        +
Ambient Temperature
        +
Humidity
        +
Compressor Current
        +
Battery Voltage / Current
        +
PV Voltage / Current
        +
Door Status
        +
PCM Temperature
        ↓
Fault Detection Logic
        ↓
Fault Classification
        ↓
Operator Alert
        ↓
Recovery Action
```

Example diagnostic logic:

```text
Temperature rising
+ Door closed
+ Compressor current = 0

→ Probable compressor failure
```

---

## 📁 Repository Structure

```text
NER-Resilient-Micro-Cold-Hub/
│
├── MATLAB/
│   ├── Simulink/
│   │   └── NER_Cold_Hub_A13_PCM.slx
│   │
│   └── scripts/
│       ├── failure_comparison.m
│       └── validate_saved_data.m
│
├── Documentation/
│   ├── system_architecture.md
│   ├── thermal_model.md
│   ├── PCM_model.md
│   └── simulation_results.md
│
├── results/
│   └── figures/
│       └── compressor_failure_A13_PCM_comparison.jpeg
│
├── Hardware/
│   └── README.md
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🚀 Running the Simulation

### Requirements

- MATLAB R2025a
- Simulink

### Open the model

Navigate to:

```text
MATLAB/Simulink/
```

and open:

```text
NER_Cold_Hub_A13_PCM.slx
```

Run the model for:

```text
64800 seconds
```

---

## 📉 Reproducing the PCM Comparison

Run the model first with the PCM connected and save the chamber-temperature output.

```matlab
PCM_data = out.Tchamber_PCM;
```

Then bypass the PCM heat-flow contribution:

```text
QPCM = 0
```

Run the same simulation again and save:

```matlab
noPCM_data = out.Tchamber_noPCM;
```

Then execute:

```matlab
failure_comparison
```

to generate the comparison plot and calculate the final temperature difference.

---

## 🔬 Current Status

### Completed

- [x] Chamber thermal model
- [x] PUF insulation heat-transfer model
- [x] Dynamic green-banana thermal model
- [x] Thermostatic refrigeration control
- [x] Compressor failure simulation
- [x] A13 PCM subsystem
- [x] PCM state-of-charge representation
- [x] With-PCM vs without-PCM failure comparison
- [x] Quantitative thermal-resilience validation

### Planned

- [ ] PV generation model
- [ ] MPPT model
- [ ] Battery SOC model
- [ ] Intelligent energy-management system
- [ ] Compressor-current fault detection
- [ ] Door-open fault detection
- [ ] Sensor fault detection
- [ ] Automatic fault classification
- [ ] Physical prototype
- [ ] Experimental Simulink validation
- [ ] Longer-duration system-autonomy study

---

## ⚠️ Engineering Scope

The current results are **simulation results**, not physical prototype measurements.

The model is intended for system-level thermal and resilience analysis. Parameters such as:

- PCM thermal contact resistance
- Refrigeration COP
- Actual compressor performance
- Product airflow
- Thermal bridging
- Door infiltration
- PCM packaging
- Spatial temperature gradients

will require experimental validation.

Accordingly, the current validated claim is limited to the simulated compressor-failure experiment.

---

## 🏆 Smart India Hackathon

This project is being developed as a **Smart India Hackathon (SIH)** solution focused on resilient decentralized cold-storage infrastructure.

The long-term objective is to combine:

**efficient refrigeration + renewable energy + energy storage + thermal storage + fault detection + rapid recovery**

into a practical micro cold-storage architecture suitable for agricultural aggregation.

---

## 🛠️ Technology Stack

- MATLAB
- Simulink
- ESP32 *(planned physical control layer)*
- Temperature / humidity sensing
- Current and voltage sensing
- Phase Change Material thermal storage
- DC refrigeration
- Solar PV and battery storage *(planned system integration)*

---

## 📌 Key Takeaway

> **The innovation is not simply keeping the cold room running — it is making the cold-storage system resilient when something goes wrong.**

The current Simulink experiment demonstrates the first part of that objective:

**A13 PCM significantly reduces chamber temperature rise during compressor failure.**
