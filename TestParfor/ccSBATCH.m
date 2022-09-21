classdef ccSBATCH
    % Compute Canada SBATCH submission arguments
    properties
        % Local script, remote working directory (home, by default)
        localScript = 'TestParfor';
        workingDirectory = '.';

        % You must specify a compute account (def, rrg, rpp or ctb type)
        account = 'def-USERNAME';

        % Nodes, cpus per task, GPUs per node
        nodes = 1;
        ntasksPerNode = 1;  % Must stay at 1
        cpusPerTask = 8;    % To allow speedup
        gpusPerNode = 0;

        % Specify the memory per CPU
        memPerCPU = '3840M'

        % Requested walltime
        walltime = '00:30:00'

        % You may use otherOptions to append a string to the qsub command
        % e.g.
        % otherOptions = '--mail-user=<email_address> --mail-type=ALL'
        otherOptions = ''
    end

    methods(Static)
        function job = submitTo(cluster)
            opt = ccSBATCH();
            optPool = 'matlabpool';
            releaseStr = version('-release');
            releaseDbl = str2double(releaseStr(1:4));
            if (releaseDbl >= 2016); optPool = 'pool'; end

            job = batch(cluster,    opt.localScript,     ...
                optPool,            opt.getNbWorkers(),  ...
                'CurrentDirectory', opt.workingDirectory ...
                );
        end
    end

    methods
        function nbWorkers = getNbWorkers(obj)
            % Automatic: the (nodes * cpusPerTask - 1) rule
            nbWorkers = obj.nodes * obj.cpusPerTask - 1;
            
            % You may also hard-code the number of workers
            %nbWorkers = 7;
        end

        function submitArgs = getSubmitArgs(obj)
            % Account
            slurmAccount = '';
            if size(obj.account) > 0
                slurmAccount = sprintf('--account=%s', obj.account);
            end

            % Compute resources (cpus, gpus, memory, time)
            compRes = sprintf('--nodes=%d --ntasks-per-node=%d --cpus-per-task=%d', ...
                obj.nodes, obj.ntasksPerNode, obj.cpusPerTask);

            if obj.gpusPerNode > 0
                compRes = sprintf('%s --gres=gpu:%d', ...
                    compRes, obj.gpusPerNode);
            end

            compRes = sprintf('%s --mem-per-cpu=%s --time=%s', ...
                compRes, obj.memPerCPU, obj.walltime);

            % Returned sbatch arguments
            submitArgs = sprintf('%s %s %s', ...
                slurmAccount, compRes, obj.otherOptions);
        end
    end
end





