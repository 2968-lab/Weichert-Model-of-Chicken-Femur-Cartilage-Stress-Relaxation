# Purpose
This repository is a physiological model of aortic pressure and blood flow in response to vessel parameters that demonstrates how statin treatment can modulate these metrics and parameters in individuals with atherosclerosis. This code was produced from a modified Windkessel model, provided by my Integrated Physiology class.

# How to Use this Repository
## Requirements
This repository requires MATLAB.

## Setup
To use this repository, modify the "inputs.m" file with your desired inputs. This file takes inputs for a healthy individual, an individual with atherosclerosis, the rate and range of statin treatment, and parameters of the vessel being modeled. Once the inputs are correct, run the "main.m" file to perform the model. The script will output graphs showing blood flow, pressure, and resistance in a single cycle of both a healthy individual and in an individual with atherosclerosis during several months of statin treatment. The script will also output a table describing the change in max aortic pressure with statin treatment over time.

# Output
This section contains the output graphs for the default parameters of this model.

Below is the output graph for a healthy individual with baseline parameters:
![Healthy Individual](Output/Healthy_Individual.png)

Below is the output graph for an individual with atherosclerosis over several months of statin treatment:
![Atherosclerosis Individual](Output/Atherosclerosis_Values.png)

Also included in the "Output" folder is a text file containing the values of a table displaying change in max aortic pressure in an individual with atherosclerosis over time.

# Background
The original Windkessel model I used inputted vascular resistance, arterial resistance, and arterial compliance, and outputted graphs of pressure and blood flow over time in the aorta.<sup>1</sup> To better model atherosclerosis, the base Windkessel script was modified to include the following equation: $C = dV/(dp) = (2∗π∗l∗r^3)/(E∗h)$, where compliance (C) is equivalent to the derivative of volume with respect to pressure,  l corresponds to the length of the vessel, r is the radius of the vessel, E is the elastic modulus of the vessel, and h is the wall thickness of the vessel.<sup>2</sup> The initial Windkessel model used a generalized arterial compliance for the aorta, and by implementing this equation into the script, four parameters can be modified to represent a change in compliance, as opposed to one. This is especially relevant for atherosclerosis and its treatment with statins since not all four of these parameters change. For instance, when an individual develops atherosclerosis, plaques develop in their blood vessels that decrease vessel radius, increase vessel wall thickness, and increase the modulus of elasticity, which represent a more narrow and rigid vessel. Treatments with statins can increase the arterial compliance; however, it does not necessarily remove the plaques, so the vessel's radius and vessel's wall thickness remain mostly the same. Instead, a statin treatment can be represented by solely changing the elastic modulus.<sup>3</sup> The addition of the compliance equation allows these nuances to be represented in the model, where some variables change while others remain the same. 

In the default inputs, a section of the aorta was modeled with a length of 300 mm, radius of 20 mm, wall thickness of 2 mm, elastic modulus of 400 kPa, diastolic pressure of 80 mmHg, vascular resistance of $0.1 mmHg*s/mL$, and arterial resistance of $1 mmHg*s/mL$.<sup>4</sup> Atherosclerosis was modeled by doubling the modulus of elasticity to 800 kPa, decreasing the vessel radius by 5% to 19 mm, and increasing the vessel wall thickness by 10% to 2.2 mm. A treatment of statins was modeled by decreasing the modulus of elasticity by 1% for every month of treatment, for a total of twelve months. From these parameters, graphs were generated displaying a single phase of pressure, blood flow, and resistance over the course of a second for the baseline conditions. The same graphs were generated for the atherosclerosis conditions, and they were regenerated after every four months of treatment with statins.

# Limitations
This model makes assumptions about the impacts of statins. Most notably, it assumes that statin treatment can produce a constant effect that solely alters elastic modulus. The purpose of this assumption was to demonstrate that only treating one parameter affected by a disease state can still produce substantial alleviation from the disease's symptoms.

# References
1. Westerhof, N., Stergiopulos, N., & Noble, M. I. M. (2008). The arterial windkessel. Medical & Biological Engineering & Computing, 47(2), 131–141. https://doi.org/10.1007/s11517-008-0359-2 
2. Brown, D. (n.d.). Thin-walled cylindrical vessel. Vermont Veterinary Cardiology Services. Retrieved December 8, 2025, from https://www.vermontveterinarycardiology.com/index.php/for-cardiologists/for-cardiologists?id=204&utm 
3. Alidadi, M., Montecucco, F., Jamialahmadi, T., Al-Rasadi, K., Johnston, T. P., & Sahebkar, A. (2021). Beneficial effect of 
statin therapy on arterial stiffness. BioMed Research International, 2021, Article 5548310. https://doi.org/10.1155/2021/5548310 
4. Turkbey, E. B., Jain, A., Johnson, C., Redheuil, A., Arai, A. E., Gomes, A. S., Carr, J., Hundley, W. G., Teixido-Tura, G., Eng, J., Lima, J. A. C., & Bluemke, D. A. (2014). Determinants and normal values of ascending aortic diameter by age, gender and race/ethnicity in the Multi-Ethnic Study of Atherosclerosis (MESA). Journal of Magnetic Resonance Imaging, 39(2), 360–368. https://doi.org/10.1002/jmri.24183 