NER-Resilient Micro Cold Hub
A MATLAB/Simulink thermal-resilience model for a decentralized micro cold-storage system designed for North-Eastern Region (NER) agricultural aggregation.

Project objective
The project investigates whether thermal buffering using an A13 phase-change material (PCM) can reduce produce-chamber temperature rise when active refrigeration fails.

The model focuses on failure resilience and low downtime, rather than treating solar power or IoT monitoring alone as the innovation.

Current simulation case
Parameter	Value
Chamber volume	30 L
Insulation	40 mm PUF
Ambient temperature	35 °C
Initial chamber temperature	13 °C
Green banana load	3 kg
Banana specific heat used	3.86 kJ/kg·K
Banana-to-chamber UA	3 W/K
Nominal cooling capacity in model	70 W
Thermostat band	12.5–13.5 °C
Compressor failure	12 h
Failure duration tested	6 h
PCM	PlusICE A13
A13 latent heat	225 kJ/kg
A13 nominal phase-change temperature	13 °C
Model architecture
The chamber energy balance is:

C_ch dT_ch/dt = Q_wall + Q_banana - Q_PCM - Q_cool

The model contains:

Ambient-to-chamber wall heat gain
Dynamic green-banana thermal model
Thermostatic refrigeration control
Compressor failure event
A13 PCM thermal-buffer subsystem
PCM enthalpy/state-of-charge representation
Chamber temperature logging
With-PCM vs without-PCM comparison
Failure-resilience result
For the current 6-hour compressor-failure simulation:

With A13 PCM: 14.8727 °C at the end of the test
Without PCM: 18.1353 °C at the end of the test
Final-temperature reduction: 3.2626 °C
Both cases remain below 15 °C during this particular 6-hour test, so this repository does not claim a 15 °C crossing-time advantage for the current run.

Interpretation
The validated result demonstrates that A13 PCM acts as a thermal buffer during compressor failure. It does not represent electrical backup. Electrical resilience is a separate system layer involving PV, battery, energy management and refrigeration.

Repository structure
NER-Resilient-Micro-Cold-Hub/
├── MATLAB/
│   ├── Simulink/
│   │   └── NER_Cold_Hub_A13_PCM.slx
│   └── scripts/
│       ├── failure_comparison.m
│       └── validate_saved_data.m
├── results/
│   └── figures/
│       └── compressor_failure_A13_PCM_comparison.jpeg
├── Documentation/
│   ├── system_architecture.md
│   ├── thermal_model.md
│   ├── PCM_model.md
│   └── simulation_results.md
├── Hardware/
│   └── README.md
├── .gitignore
├── LICENSE
└── README.md
How to reproduce the comparison
Open MATLAB/Simulink/NER_Cold_Hub_A13_PCM.slx in MATLAB/Simulink.
Run the model with the A13 PCM connected.
Save the resulting Tchamber timeseries as PCM_data.
Bypass the Q_PCM contribution at the chamber heat-balance sum.
Run the same model again without PCM.
Save the resulting Tchamber timeseries as noPCM_data.
Run MATLAB/scripts/failure_comparison.m.
The two cases must be separate simulation runs. Two logging blocks connected to the same Tchamber signal do not create independent PCM/no-PCM experiments.

Software
MATLAB R2025a
Simulink
Project status
Current stage: thermal/failure-resilience simulation validated for the 30 L design case.

Future work can add:

PV generation model
MPPT
battery state-of-charge
intelligent energy management
compressor-current fault detection
door-open fault detection
recovery logic
physical prototype validation
longer-duration energy/autonomy analysis
Engineering note
The current simulation is a lumped thermal model intended for system-level validation. Parameters such as heat-transfer coefficients, refrigeration performance, PCM packaging and thermal contact resistance should be experimentally validated before commercial-scale claims are made.

License
MIT License. See LICENSE.
