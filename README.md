# MATLAB Parallel Server Samples

To configure MATLAB Parallel Server in your local MATLAB, please follow this documentation section: https://docs.computecanada.ca/wiki/MATLAB#Using_the_MATLAB_Parallel_Server

To validate your configuration, please try the `TestParfor` example:

```
cluster = parcluster('beluga');
ccSBATCH.submitTo(cluster)
```
For each code to be submitted to the cluster, you will need a `ccSBATCH.m` file in the current working directory.
