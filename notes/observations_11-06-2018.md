# Results

## Pipeline

1. Visually inspect filtered (0.1 Hz highpass) for obvious bad channels
2. ICA decomposition:
    1. Highpass filter (1 Hz)
    2. epoch into dummy consecutive epochs (length 2sec)
    3. Remove bad channels from visual inspection
    4. get rid of non-stereotypical artifacts (z-value, threshold 20)
    5. train runica (no dimensionality reduction)
    6. read in the raw data again
    7. apply the ica weights to the unprocessed raw data
3. filter:
    1. Highpass: 0.1 Hz, 4530-order FIR
    2. Lowpass: 40 Hz, 60-order FIR
4. Automatic artifact rejection:
    1. SQUID electrode jumps: Z-score (threshold 20)
    2. Thresholding +/- 400µv

## EOG artifact removal

Very clear eyeblinks, especially in Fp1 and Fp2
(Subject: s1001, Highpass filtered 0.1 Hz with ~4530-order FIR)

![alt text](img/pre_ICA.png)

After ICA reconstruction
![alt text](img/post_ICA.png)

## Re-referencing

Changes ERP dramatically:

No re-referencing:
![alt text](img/s1004.png)

With average re-referencing:
![alt text](img/s1004_rereferenced_avg.png)

## ERP Analysis

### Grand average by subject

### Controls

#### s1005 (CONTROL)

![alt text](img/s1005.png)

#### s1008 (CONTROL)

![alt text](img/s1008.png)

#### s1021 (CONTROL)

![alt text](img/s1021.png)

#### s1022 (CONTROL)

![alt text](img/s1022.png)

### Patients

#### s1001 (PATIENT)

![alt text](img/s1001.png)

#### s1003 (PATIENT)

![alt text](img/s1003.png)

#### s1004 (PATIENT)

![alt text](img/s1004.png)

#### s1006 (PATIENT)

![alt text](img/s1006.png)

#### s1007 (PATIENT)

![alt text](img/s1007.png)

#### s1009 (PATIENT)

![alt text](img/s1009.png)

#### s1010 (PATIENT)

![alt text](img/s1010.png)

#### s1011 (PATIENT)

![alt text](img/s1011.png)

#### s1012 (PATIENT)

![alt text](img/s1012.png)

#### s1013 (PATIENT)

![alt text](img/s1013.png)

#### s1014 (PATIENT)

![alt text](img/s1014.png)

#### s1015 (PATIENT)

![alt text](img/s1015.png)

#### s1016 (PATIENT)

![alt text](img/s1016.png)

#### s1017 (PATIENT)

![alt text](img/s1017.png)

#### s1018 (PATIENT)

![alt text](img/s1018.png)

#### s1019 (PATIENT)

![alt text](img/s1019.png)

#### s1020 (PATIENT)

![alt text](img/s1020.png)

#### s1023 (PATIENT)

![alt text](img/s1023.png)

#### s1024 (PATIENT)

![alt text](img/s1024.png)

## Frequency

### Full spectrum (PATIENT)

![alt text](img/full_spectrum_patient.png)

### Full spectrum (CONTROL)

![alt text](img/full_spectrum_control.png)

### Patient

#### delta (PATIENT)

![alt text](img/topo_patient_delta.png)

#### theta (PATIENT)

![alt text](img/topo_patient_theta.png)

#### alpha (PATIENT)

![alt text](img/topo_patient_alpha.png)

#### low gamma (PATIENT)

![alt text](img/topo_patient_low_gamma.png)

#### high_gamma (PATIENT)

![alt text](img/topo_patient_high_gamma.png)

### Control

#### delta (CONTROL)

![alt text](img/topo_control_delta.png)

#### theta (CONTROL)

![alt text](img/topo_control_theta.png)

#### alpha (CONTROL)

![alt text](img/topo_control_alpha.png)

#### low gamma (CONTROL)

![alt text](img/topo_control_low_gamma.png)

#### high_gamma (CONTROL)

![alt text](img/topo_control_high_gamma.png)

