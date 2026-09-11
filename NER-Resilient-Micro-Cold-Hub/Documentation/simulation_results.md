# Simulation Results

## Compressor-failure experiment

The compressor is forced to fail at 12 hours. The model is then observed for another 6 hours, ending at 18 hours.

### Results

| Metric | With A13 PCM | Without PCM |
|---|---:|---:|
| Temperature at failure | 13.4991 °C | 13.4991 °C |
| Final temperature | 14.8727 °C | 18.1353 °C |
| Temperature rise after failure | 1.3736 °C | 4.6362 °C |
| Final-temperature reduction | 3.2626 °C | — |

The current run shows both cases below 15 °C at the end of the 6-hour failure window. Therefore the repository does not claim that the no-PCM case crosses 15 °C during this particular run.

## Main conclusion

A13 PCM substantially reduces chamber temperature rise during compressor failure:

**18.1353 °C → 14.8727 °C**

This supports the project's thermal-resilience and low-downtime design objective.

## SIH-safe statement

> Under a 6-hour compressor-failure simulation, A13 PCM reduced the final chamber temperature from 18.14 °C to 14.87 °C, a reduction of approximately 3.26 °C, demonstrating thermal buffering during cooling failure.

This is a simulation result and should be presented as such until physically validated.
