function TestParfor()

% Example of using parfor loop.
%
% This code generates 14 random 4000x4000 complex matrices, and then 
% performs their inversion one-by-one in a standard "for" loop, and
% in parallel using a "parfor" loop.
%
% Use ccSBATCH.m file to set the number of nodes and CPUs per task
% for your job, as well as requested walltime for the job.
% Make sure that total number of reserved cores (nodes * cpusPerTask)
% is equal or larger than matlabpool+1.
% Note: one ccSBATCH.m file must always be in your project directory
%       (together with your main matlab script).
%
% Job submission commands:
%
%  >> cluster = parcluster('beluga');  % or 'narval'
%  >> ccSBATCH.submitTo(cluster)

clear all;

N = 4000;
logFile = '~/scratch/output_test_parfor.log';

outfile = fopen(logFile, 'w');
fprintf(outfile, '*** TestParfor *** \n\n');
fclose(outfile);

tic;
for k = 1:14
    bigMatrix3D(:,:,k) = rand(N) + 1i * rand(N);
    outfile = fopen(logFile, 'a');
    fprintf(outfile, 'Serial: Doing K-point : %3i\n', k);
    fclose(outfile);
    inv(bigMatrix3D(:,:,k));
end
t2 = toc;

outfile = fopen(logFile, 'a');
fprintf(outfile, 'Time serial = %12f\n\n', t2);
fclose(outfile);

tic;
parfor k = 1:14
    bigMatrix3D(:,:,k) = rand(N) + 1i * rand(N);
    outfile = fopen(logFile, 'a');
    fprintf(outfile, 'Parallel: Doing K-point : %3i\n', k);
    fclose(outfile);
    inv(bigMatrix3D(:,:,k));
end
t2 = toc;

outfile = fopen(logFile, 'a');
fprintf(outfile, 'Time parallel = %12f\n\n', t2);
fclose(outfile);

