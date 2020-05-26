# MATLAB Parallel Server Samples

To configure MATLAB Parallel Server in your local MATLAB, please follow this documentation section: https://docs.computecanada.ca/wiki/MATLAB#Using_the_MATLAB_Parallel_Server

To validate your configuration, please try the `TestParfor` example:
1. Edit the `ccSBATCH.m` script in order to set your compute `account`. Save this file.
2. In the MATLAB prompt, run the following commands:
```
cluster = parcluster('beluga');
ccSBATCH.submitTo(cluster)
```
3. In the Job Monitor (Parallel > Monitor Jobs), select the corresponding profile. Note: your job may remain in queue for a while depending on your priority and available resources. You may connect to the cluster (with a regular SSH connection) and check the status of your job.
4. When the job is running, you may connect to the cluster (with a regular SSH connection) and follow the execution with:
```
tail -f ~/scratch/output_test_parfor.log
```

Yes, the final output remains on the cluster. For your own MATLAB code, the input dataset may also be on the cluster. That way, you avoid copying large files between your computer and the cluster.

**REMINDER**: For each code to be submitted to the cluster, you will need a `ccSBATCH.m` file in the current working directory.
