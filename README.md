# Microstructural Brain Correlates of Inter-individual Differences in Respiratory Interoception  
### Niia Nikolova, Jesper Fischer Ehmsen, Leah Banellis, Malthe Brændholt, Melina Vejlø, Francesca Fardo, Micah Allen

Public repository containing the data, source code, and figures for this project, to be made accessible upon the manuscript's acceptance in a peer-reviewed journal.


## Abstract
Interoception, the perception and integration of physiological signals, is a fundamental aspect of self-awareness and homeostasis. While previous work has explored interoceptive processing in relation to the cardiac system, research in the respiratory domain, particularly in relation to brain structure and function, is limited. To address this gap, we utilised a Bayesian psychophysical model to quantify perceptual, metacognitive, and affective dimensions of respiratory interoception in a sample of 207 healthy participants. We also measured individual whole-brain microstructural indices of myelination, myeloarchitecture, and cortical iron using quantitative brain imaging. Voxel-based quantification analyses revealed distinct patterns of cortical microstructure in the insular, cingulate, and primary sensory cortices, which underpin interoceptive perceptual sensitivity and precision. In addition, metacognitive bias was associated with increased myelination of the cingulate cortex and periaqueductal grey, while metacognitive sensitivity correlated with myelination of the midline prefrontal cortex. At an affective level, sensitivity to respiratory resistance was related to the myelination of the primary somatosensory cortex. By revealing specific histological brain patterns tied to individual differences in respiratory interoception, our results uncover the neural pathways that govern perceptual, metacognitive, and emotional facets of interoceptive processing.


## Preprint
https://www.biorxiv.org/content/10.1101/2024.04.08.588519v1

## Citation
To reference this work in your research, please cite as follows:
Nikolova, N., Ehmsen, J. F., Banellis, L., Brændholt, M., Vejlø, M., Fardo, F., & Allen, M. (2024). Microstructural Brain Correlates of Inter-individual Differences in Respiratory Interoception. bioRxiv. https://doi.org/10.1101/2024.04.08.588519


## Directory structure
```bash
├── LICENSE
├── README.md                                    # Project overview
├── Respiroception_VBQ_pyenv.yml                 # Python environment file, listing all necessary packages for reproducibility   
├── analysis                                     # Direcory containing behavioural analysis code
│   ├── respirocept_behav_analysis.ipynb         # Jupyter notebook for reproduction of behavioural RRST analysis 
│   └── rrst_behav_jasp.jasp                     # JASP analysis file, for rmANOVA of unpleasantness ratings
├── data                                         # Directory containing pre-processed behavioural RRST data
│   ├── 1-respirocept_regressors_vbq.csv         # Regressors file used for the VBQ analysis
│   ├── rrst_behav_data_full.csv                 # Full RRST behaviourla data (before exclusions)
│   └── rrst_behav_data_vbq_subset.csv           # RRST behaviourla data (after exclusions)
└── figures                                      # Directory containing figure for the pubication
    ├── fig_01
    ├── fig_02
    ├── ...
```
## Access


## Reproducibility


## Usage
