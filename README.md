# cme207 - Lid Driven Cavity Flow
Numerical simulator for 2D - lid driven cavity problem


## Governing Equations
Incompressible Navier Stokes Equation

## Feature method
* Staggered grid
* Prediction-correction method
* Upwinding discretizatoin

## Example Results

*  Pressure field
<img src="https://github.com/jiaweili238/cme207-lid_driven_flow/blob/master/Simulator/result/Pressure_Re_10000_N_161.jpg" width="300" height="250" />

*  Velocity field

<div class="row">
  <div class="column">
    <img src="https://github.com/jiaweili238/cme207-lid_driven_flow/blob/master/Simulator/result/Ux_Re_10000_N_161.jpg" width="300" height="250">
  </div>
  <div class="column">
    <img src="https://github.com/jiaweili238/cme207-lid_driven_flow/blob/master/Simulator/result/Uy_Re_10000_N_161.jpg" width="300" height="250">
  </div>
</div>

## Usage

```
Simulator/main.m
```
You can define Reynolds number, grid size and time step. 
