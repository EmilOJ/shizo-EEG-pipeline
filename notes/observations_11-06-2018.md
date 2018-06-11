# Date observations

## Channel rejection

Very clear eyeblinks, especially in Fp1 and Fp2
(Subject: s1001, Highpass filtered 0.1 Hz with 4000-order FIR)

![alt text](img/fp1fp2noise.png)

![alt text](img/test.png)

## Pipeline documentation

1. Visually inspect filtered (0.1 Hz highpass) for obvious bad channels
2. ICA decomposition:
    1. read the data
    2. Highpass filter (1 Hz)
    3. epoch into dummy consecutive epochs (length 2sec)
    4. Remove bad channels from visual inspection
    5. get rid of non-stereotypical artifacts (z-value, threshold 20)
    6. train extended infomax ica (no dimensionality reduction)
    8. read in the raw data again
    9. apply the ica weights to the unprocessed raw data
    10. filter and re-reference the raw data, tailored towards the features of interest
    11. get rid of artifacts by back-projection of all but the artifact ICs (I suggest using CORRMAP for the classification process, it is near objective and very robust, we get plenty positive feedback from other labs)
    12. extract events      