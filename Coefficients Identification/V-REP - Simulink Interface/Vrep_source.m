%% This S-function implements the Simulink callback functions necessary to 
%  communicate with a VRep scene. In particular, the Simulink block that uses this 
%  S-function is intended to communicate synchronously with a
%  VRep scene that runs in real-time mode. 
%  Matlab uses its discrete time steps to command the VRep simulation. In
%  order to synchronize the simulations in Vrep and Matlab, the
%  communication must be properly initialized (see the initialization
%  script) and, before sending any command to the server, the Matlab client
%  needs to send a trigger signal, which is a blocking operation, with the
%  function call  vrep.simxSynchronousTrigger(clientID);
%
% The following initialization script is inserted in the InitFcn callback of
% the Simulink block (File->Model Properties->Model Properties->Callbacks):
%
%  %------ START OF THE INITIALIZATION SCRIPT ------
%  clc
%  global clientID
%  global vrep
%  global joint4Handle
% 
%  addpath('C:\Program Files (x86)\V-REP3\V-REP_PRO_EDU\programming\remoteApiBindings\lib\lib\32Bit')
%  disp('Program started');
%  vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
%  vrep.simxFinish(-1); % just in case, close all opened connections
%  clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5);
% 
%  vrep.simxStartSimulation(clientID,vrep.simx_opmode_oneshot_wait);
%  vrep.simxSynchronous(clientID,true)
% 
%  if (clientID<=-1)
%     disp('stop simulation')
%     vrep.delete();
%     set_param(gcs, 'SimulationCommand', 'stop')
%  end
% 
%  [res,joint4Handle]=vrep.simxGetObjectHandle (clientID,'LBR4p_joint1',vrep.simx_opmode_oneshot_wait);
%
%  %------ END OF THE INITIALIZATION SCRIPT ------
%
% Similarly, the termination script is inserted in the StopFnc callback:
%
%
%  %------ START OF THE TERMINATION SCRIPT ------
%   global clientID
%   vrep.simxStopSimulation(clientID,vrep.simx_opmode_oneshot_wait);
%
%  %------ END OF THE TERMINATION SCRIPT ------




function Vrep_source(block)
% Level-2 MATLAB file S-Function for inherited sample time demo.
%   Copyright 1990-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $ 

  setup(block);
  
%endfunction

function setup(block)
  
  %% Register number of input and output ports
  block.NumInputPorts  = 0;
  block.NumOutputPorts = 7;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
  
  for i=1:7
        block.OutputPort(i).SamplingMode = 0;
        block.OutputPort(i).Dimensions = 1;
  end
  
  
  %% Set block sample time to inherited
  block.SampleTimes = [-1 0];
  
  %% Set the block simStateCompliance to default (i.e., same as a built-in block)
  block.SimStateCompliance = 'DefaultSimState';

  %% Register methods
  block.RegBlockMethod('Outputs', @Outputs);     % Required
  block.RegBlockMethod('Terminate', @Terminate); % Required
    
%endfunction

function Outputs(block)
  global clientID vrep vecJoints nJoints
  
  
  
  for i=1:nJoints
      if vecJoints(i) ~= -1
        	[res,pos] = vrep.simxGetJointPosition(clientID,vecJoints(i),vrep.simx_opmode_streaming);
            if res==0
                block.OutputPort(i).Data = double(pos);    
            else
                block.OutputPort(i).Data = 0;
            end
      end
  end
  vrep.simxSynchronousTrigger(clientID);
  
%endfunction




function Terminate(block)

%end Terminate