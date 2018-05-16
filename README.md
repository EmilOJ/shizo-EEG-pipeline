## Getting started

### Installing dependencies

This project uses the `mpm` MATLAB package manager whihc is included in the `mpm/` folder in the root directory. To install dependencies follow these steps:

1. In MATLAB add the `mpm/` folder to paths. 
2. From the MATLAB command line, run mpm_install. 

The dependencies are now automatically installed into the `mpm/mpm-packages/` directory and automatically added to your MATLAB paths.

### Setup paths for your machine

A `data` folder is required for the pipeline to run on data. This folder must only be saved locally due to the data access law. Ask Emil about this.

The project is divided into two analysis: _ERP_ (Event-related potentials), and _default mode network_ (steady-state). There is a corresponding folder for each analysis. The following instructions work for both.

1. Create a copy of `config_sample.m` in the same directory and name it `my_config.m`.
2. `my_config.m` contains absolute paths and could look like this:

```matlab
my_root = '/Users/emiljohansen/Documents/Laosdirg/Roskilde'; % Path to root folder
my_output_folder = '/Users/emiljohansen/Documents/Roskilde/steadystate'; % Path to processed data output
my_fieldtrip_path = '/Users/emiljohansen/Documents/Laosdirg/Roskilde/roskilde-eeg-pipeline/fieldtrip'; % Path to fieldtrip
```

### Run the analysis

Run the file `run_pipeline_steadystate.m`
